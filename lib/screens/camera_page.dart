// lib/screens/camera_page.dart
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;

// 만약 main.dart에서 전역 변수를 사용한다면 해당 경로로 import하세요.
// 예: import 'package:your_project_name/main.dart';

class CameraPage extends StatefulWidget {
  final String muscleGroup;
  final String tool;
  final String workoutName;
  final int setCount;
  final double? weight;

  const CameraPage({
    Key? key,
    required this.muscleGroup,
    required this.tool,
    required this.workoutName,
    required this.setCount,
    this.weight,
  }) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  bool _initialized = false;
  int _cameraIndex = 0; // 전/후면 전환
  bool _isFlashVisible = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initCamera(_cameraIndex);
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('권한 필요'),
          content: const Text('카메라 권한이 필요합니다.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
  }

  Future<void> _initCamera(int index) async {
    if (index < 0) return;
    await _controller?.dispose();
    // availableCameras()를 호출하여 카메라 목록을 얻음
    final cameras = await availableCameras();
    if (index >= cameras.length) return;
    final desc = cameras[index];
    _controller = CameraController(
      desc,
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await _controller!.initialize();
      debugPrint('카메라 초기화 성공 => ${_controller!.description}');
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      debugPrint('카메라 초기화 실패: $e');
      if (!mounted) return;
      showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('오류'),
            content: Text('카메라 초기화 실패: $e'),
            actions: [
              CupertinoDialogAction(
                child: const Text('확인'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
    }
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    if (cameras.length < 2) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('알림'),
          content: const Text('전/후면 카메라가 없습니다.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
      return;
    }
    setState(() => _initialized = false);
    _cameraIndex = (_cameraIndex + 1) % cameras.length;
    await _initCamera(_cameraIndex);
  }

  Future<void> _capturePhoto() async {
    if (!(_controller?.value.isInitialized ?? false)) return;
    try {
      final XFile image = await _controller!.takePicture();
      // defaultStoragePath 는 실제 내장 저장 경로
      final Directory directory = Directory('/storage/emulated/0/DCIM/Camera');
      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }
      final String savePath = path.join(
        directory.path,
        'captured_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await image.saveTo(savePath);
      debugPrint('사진 저장 완료 => $savePath');
      setState(() {
        _isFlashVisible = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _isFlashVisible = false;
        });
      });
    } catch (e) {
      debugPrint('사진 촬영 실패: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTapFocus(TapDownDetails details, BoxConstraints constraints) {
    if (!(_controller?.value.isInitialized ?? false)) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final tapPos = box.globalToLocal(details.globalPosition);
    final relX = tapPos.dx / constraints.maxWidth;
    final relY = tapPos.dy / constraints.maxHeight;
    _controller?.setFocusPoint(Offset(relX, relY));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('CameraPage build');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('카메라 페이지'),
        trailing: GestureDetector(
          onTap: _switchCamera,
          child: const Icon(CupertinoIcons.switch_camera),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildPreviewWidget(),
                  AnimatedOpacity(
                    opacity: _isFlashVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: CupertinoColors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton.filled(
                    child: const Icon(CupertinoIcons.camera),
                    onPressed: _capturePhoto,
                  ),
                  CupertinoButton(
                    child: const Text('이전 화면'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewWidget() {
    if (!_initialized) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.previewSize!.height,
                height: _controller!.value.previewSize!.width,
                child: GestureDetector(
                  onTapDown: (details) => _onTapFocus(details, constraints),
                  child: CameraPreview(_controller!),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
