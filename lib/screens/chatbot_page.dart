import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  // 기본 챗봇 URL (반드시 Chatbase에서 제공한 실제 챗봇 iFrame URL로 교체하세요)
  String baseChatbotUrl = 'https://www.chatbase.co/chatbot-iframe/mUfeu6gtJo79IzLl3crec';

  /// Firestore에서 사용자 정보를 불러와 초기 메시지를 구성하고,
  /// 이를 query parameter로 추가한 URL을 반환하는 함수
  Future<String> _buildChatbotUrl() async {
    final user = FirebaseAuth.instance.currentUser;
    String initMessage = "안녕하세요!"; // 기본 메시지
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        final userName = data?['name'] ?? '사용자';
        final height = data?['height'] ?? '';
        final weight = data?['weight'] ?? '';
        double bmi = 0;
        try {
          double heightMeter = double.parse(height) / 100;
          double weightKg = double.parse(weight);
          bmi = weightKg / (heightMeter * heightMeter);
        } catch (e) {
          bmi = 0;
        }
        String bmiStr = bmi > 0 ? bmi.toStringAsFixed(1) : '계산불가';
        String bodyType = '';
        if (bmi == 0) {
          bodyType = 'BMI 계산 불가';
        } else if (bmi < 18.5) {
          bodyType = '저체중';
        } else if (bmi < 23) {
          bodyType = '정상체중';
        } else if (bmi < 25) {
          bodyType = '과체중';
        } else {
          bodyType = '비만';
        }
        initMessage =
        "안녕하세요 $userName 님! 귀하의 키는 $height cm, 몸무게는 $weight kg입니다. 계산한 BMI는 $bmiStr이고, 체형은 $bodyType입니다. 무엇을 도와드릴까요?";
      }
    }
    // URL에 initMessage 쿼리 파라미터 추가 (Chatbase에서 이 파라미터를 초기 메시지로 활용하도록 구성되어 있어야 합니다)
    String encodedMessage = Uri.encodeComponent(initMessage);
    String fullUrl = "$baseChatbotUrl?initMessage=$encodedMessage";
    debugPrint("구성된 챗봇 URL: $fullUrl");
    return fullUrl;
  }

  /// WebViewController를 초기화하고 로딩을 완료하는 함수
  Future<void> _initChatbot() async {
    String chatbotUrlWithParams = await _buildChatbotUrl();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(chatbotUrlWithParams));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initChatbot();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('고민해결 챗봇'),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}
