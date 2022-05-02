import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/FirebaseController.dart';

class DrawerView extends StatelessWidget {
  DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseController firebaseController = Get.find();

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: LinearGradient(
                    begin: Alignment(-.7, .5),
                    end: Alignment.centerRight,
                    colors: [
                      Colors.green,
                      Colors.lightGreenAccent,
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: 40,
                      child: CachedNetworkImage(
                        imageUrl:
                            firebaseController.getCurrentUser()?.photoURL ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => Icon(
                          Icons.account_circle_rounded,
                          color: Colors.grey,
                          size: 80,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.account_circle_rounded,
                          color: Colors.grey,
                          size: 56,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      getName(firebaseController),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ID:${firebaseController.getCurrentUser()?.uid}",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: InkWell(
              onTap: () {
                firebaseController.logout();
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 24.0,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getName(FirebaseController firebaseController) {
    var phoneNumber = firebaseController.getCurrentUser()?.phoneNumber;
    var displayName = firebaseController.getCurrentUser()?.displayName;
    var email = firebaseController.getCurrentUser()?.email;
    if (phoneNumber != null && phoneNumber.isEmpty) {
      phoneNumber = null;
    }
    if (displayName != null && displayName.isEmpty) {
      displayName = null;
    }
    if (email != null && email.isEmpty) {
      email = null;
    }
    return phoneNumber ?? displayName ?? email ?? "name";
  }
}
