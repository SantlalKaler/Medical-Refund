import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/presentation/app/routes/app_pages.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // Initialize Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('install');
  //connect();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
    });
  }

  void _getToken() async {
    String? token = await messaging.getToken();
    PrefData.saveToken(token!);
    print('Device Token: $token');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
          useMaterial3: false,
          primaryColor: Colors.teal.shade600,
          primarySwatch: Colors.teal,
          // datePickerTheme:
          //     DatePickerThemeData(colo),
          cardTheme: CardTheme(
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),
      routes: AppPages.routes,
    );
  }
}
