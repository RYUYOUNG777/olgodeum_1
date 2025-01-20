import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(const MyApp());
}
