
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:wollu/screen/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  KakaoSdk.init(
    nativeAppKey: '456c69cd89e100bced18bfefe46ab685'
  );
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: [
          NavigationHistoryObserver()
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
            primaryColor: Colors.black,
            fontFamily: 'Pretendard'
        ),
        home: const Scaffold(
          body: LoginScreen(),
        )
    );
  }
}
