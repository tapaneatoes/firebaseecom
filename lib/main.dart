import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseecom/home_page.dart';
import 'package:firebaseecom/ui/CartPage.dart';
import 'package:firebaseecom/ui/auth_gate.dart';
import 'package:firebaseecom/ui/login_page.dart';
import 'package:firebaseecom/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: Constants.HOME_PAGE, page: () => HomePage()),
      GetPage(name: Constants.LOGIN_PAGE, page: () => LoginPage()),
      GetPage(name: Constants.AUTH_GATE, page: () => AuthGate()),
      GetPage(name: Constants.CART_PAGE, page: () => CartPage())
    ],
    initialRoute: Constants.AUTH_GATE,
  ));
}
