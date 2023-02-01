import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta/providers/auth_provider.dart';
import 'package:insta/providers/lang_provider.dart';
import 'package:insta/screens/splash_screen.dart';
import 'package:insta/shared/enums.dart';
import 'package:insta/shared_prefernces/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBwONfUJ4p0PfF5_3MnjTEoTInVcS76COo",
            authDomain: "instagram-6bf91.firebaseapp.com",
            projectId: "instagram-6bf91",
            storageBucket: "instagram-6bf91.appspot.com",
            messagingSenderId: "350203967523",
            appId: "1:350203967523:web:c270b927c62608793ad996"
        ));
  } else {
    /// Firebase
    await Firebase.initializeApp();
  }

  /// Shared Preferences
  await SharedPreferencesController().initSharedPreferences();

 /// Notifications
 // await FbNotifications.initNotifications();

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.subscribeToTopic('general');

  FirebaseMessaging.instance.getToken().then((value) {
    SharedPreferencesController()
        .setter(type: String, key: SpKeys.fcmToken, value: value ?? '');
    print('Fcm Token ==> $value');
    print('Finish');
  }).catchError((onError) {});

  /// Setter
  await setter();

  /// Alarm
 // await AndroidAlarmManager.initialize();

  /// App
  runApp(const MyApp());
}

Future<void> setter() async {
  if (SharedPreferencesController()
      .getter(type: String, key: SpKeys.language)
      .toString() ==
      '') {
    await SharedPreferencesController()
        .setter(type: String, key: SpKeys.language, value: 'en');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LangProviders>(
          create: (context) => LangProviders(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: const SplashScreen(),

            // const ResponsiveDesign(myWebScreen: WebScreen(), myMobileScreen: MobileScreen(),
            // ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            locale: Locale(Provider.of<LangProviders>(context).lang_),
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
          );
        },
      ),
    );


  }

}
