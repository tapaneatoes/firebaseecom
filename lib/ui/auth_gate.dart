import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseecom/api/ApiProvider.dart';
import 'package:firebaseecom/controller/FirebaseController.dart';
import 'package:firebaseecom/controller/MenuController.dart';
import 'package:firebaseecom/home_page.dart';
import 'package:firebaseecom/ui/login_page.dart';
import 'package:firebaseecom/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGate extends GetView<FirebaseController> {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FirebaseController());
    Get.lazyPut(() => ApiProvider());
    Get.put(MenuController(apiProvider: Get.find()));
    return StreamBuilder<User?>(
      stream: controller.getFirebaseAuth().authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoginPage();
        }
        return HomePage();
      },
    );
  }
}
