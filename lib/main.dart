import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kp_mobile/app/values/colors.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        return GetMaterialApp(
          title: "Application",
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              accentColor: AppColor.accent,
              backgroundColor: Colors.white,
              primaryColorDark: AppColor.secondary,
            ),
          ),
        );
      }
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Text('Something went wrong!'),
          ),
        ),
      );
    },
  ));
}
