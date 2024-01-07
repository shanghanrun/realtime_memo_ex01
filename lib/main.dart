import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:realtime_memo_ex01/memo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //다른 파일에서 최기화를 또 하더라도 main에서 해주는 것이 좋다.
  // 특히 options를 main에서 수행하고, 다른 파일에서는 options를 안해도 된다.
  // final dbRef = FirebaseDatabase.instance.reference();  메인에서 사용할 경우 코드
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemoPage(),
    );
  }
}
