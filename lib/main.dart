
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wollu/screen/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wollu/screen/main_origin.dart';
import 'package:wollu/screen/splash_screen.dart';
import 'package:wollu/util/app_styles.dart';
import 'package:wollu/util/db_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'entity/User.dart';

void main() async {
  KakaoSdk.init(
    nativeAppKey: '456c69cd89e100bced18bfefe46ab685'
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    initializeDateFormatting().then((_) => runApp(MyApp()));
  });
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  User? currentUser;
  DBHelper helper = DBHelper();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      check().then((value) => {
        if (value is User) {
          currentUser = value,
          isLoggedIn = prefs.getBool('isLoggedIn') ?? false,
          setState((){})
        }
      });
      prefs.setBool('reset', false);
    });
  }

  Future<dynamic> check() async {
    final user = await helper.get();
    if (user.isEmpty) {
      return false;
    } else {
      return user.last;
    }
  }

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
            primaryColor: Styles.blueGrey,
            fontFamily: 'Pretendard'
        ),
        home: Scaffold(
            body: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator()); // Replace with a loading screen if desired
                }
                SharedPreferences prefs = snapshot.data!;
                bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
                if (!isLoggedIn) {
                  return LoginScreen(onLogin: () {
                    prefs.setBool('isLoggedIn', true);
                    setState(() {
                      isLoggedIn = true;
                    });
                  });
                } else {
                  if (currentUser == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Main(currentUser: currentUser!);
                  }
                }
              },
            )
        )
    );
  }
}
