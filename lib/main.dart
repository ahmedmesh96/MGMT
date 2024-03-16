import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mgmt/auth/log_in.dart';
import 'package:mgmt/controller/language_change_controller.dart';
import 'package:mgmt/firebase_options.dart';
import 'package:mgmt/generated/l10n.dart';
import 'package:mgmt/provider/push_notifications.dart';
import 'package:mgmt/provider/user_provider.dart';
import 'package:mgmt/screens/mobile_web_page.dart';
import 'package:mgmt/screens/splash_screen.dart';
import 'package:mgmt/widgets/snack_bar.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String language = "en";

final navigatorKey = GlobalKey<NavigatorState>();

// function to lisen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString("language_code") ?? "";

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
      // navigatorKey.currentState!.push(MaterialPageRoute(builder: (c)=>ReservationInfoScreen(uiddd: "8U6cgZgOT1hih1Yi9yZQu5BfB9X2")));
    });
  }

  runApp(MyApp(
    locale: languageCode,
  ));
  // });
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageChangeController())
      ],
      child: Consumer<LanguageChangeController>(
          builder: (context, provider, child) {
        if (locale.isEmpty) {
          provider.changeLanguage(const Locale("en"));
        }
        return ChangeNotifierProvider(
          create: (context) {
            // return UserProvider();
            return UserProvider();
          },
          child: MaterialApp(
            navigatorKey: navigatorKey,
            locale: locale == ""
                ? const Locale("en")
                : provider.appLocale == null
                    ? Locale("en")
                    : provider.appLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Reservation',
            theme: ThemeData.dark(),
            home: 
            StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      } else if (snapshot.hasError) {
                        return showSnackBar(context, "Something went wrong");
                      } else if (snapshot.hasData) {
                        return
                            // VerifyEmailPage();
                            const MobileScreen();
                      } else {
                        return const Login();
                      }
                    },
                  )
                  
                  ),
          );
        
      }),
    );
  }
}
