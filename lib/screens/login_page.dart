// lib/screens/login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      // 기존 Google 로그인 세션 초기화
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await _auth.signInWithCredential(credential);
    } catch (e, st) {
      debugPrint('구글 로그인 에러: $e\n$st');
      if (!mounted) return;
      showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('로그인 에러'),
            content: Text('Google Sign-In 실패: $e'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('확인'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('로그인')),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로그인 배너 이미지
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/login_banner.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              CupertinoButton.filled(
                onPressed: _signInWithGoogle,
                child: const Text('구글 계정으로 로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
