import 'package:firebase_messaging/firebase_messaging.dart';

import 'presentation/base/constant.dart';
import 'presentation/base/pref_data.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    await _fcm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Constant.printValue('Got a message whilst in the foreground!');
      Constant.printValue('Message data: ${message.data}');

      if (message.notification != null) {
        Constant.printValue('Message also contained a notification: ${message.notification?.title}');
      }
    });


    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // Get the token
    await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    Constant.printValue('Token: $token');
    PrefData.saveToken(token!);
    return token;
  }

}
  Future<void> backgroundHandler(RemoteMessage message) async {
    Constant.printValue('Handling a background message ${message.messageId}');
  }
