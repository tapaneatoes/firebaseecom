import 'package:badges/badges.dart';
import 'package:firebaseecom/controller/CartController.dart';
import 'package:firebaseecom/controller/FirebaseController.dart';
import 'package:firebaseecom/model/MenuDetails.dart';
import 'package:firebaseecom/ui/TabController.dart';
import 'package:firebaseecom/ui/dish_item_page.dart';
import 'package:firebaseecom/ui/drawer.dart';
import 'package:firebaseecom/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/MenuController.dart';

class HomePage extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    final FirebaseController firebaseController = Get.put(FirebaseController());
    final GetTabController pageController = Get.put(GetTabController());
    final CartController cartController = Get.put(CartController());

    final GetTabController getTabController = Get.find();

    return controller.obx((state) {
      var first = state?.first;
      final pageController = TabController(
          length: first?.tableMenuList?.length ?? 0, vsync: getTabController);

      var showBadge = ValueBuilder<bool>(
        initialValue: false,
        builder: (value, updateFn) => Switch(
          value: value,
          onChanged:
              updateFn, // same signature! you could use ( newValue ) => updateFn( newValue )
        ),
        // if you need to call something outside the builder method.
        onUpdate: (value) => print("Value updated: $value"),
        onDispose: () => print("Widget unmounted"),
      );

      return Scaffold(
        drawer: DrawerView(),
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: [
            GetBuilder<CartController>(builder: ((ctrl) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: InkWell(
                  onTap: () {
                    if (ctrl.cartDetails.value.length > 0)
                      Get.toNamed(Constants.CART_PAGE);
                    else
                      Get.snackbar("Cart is Empty", "Please add some items to place the order!");
                  },
                  child: Badge(
                    position: BadgePosition.center(),
                    showBadge: ctrl.cartDetails.value.length > 0,
                    badgeColor: Colors.red,
                    animationType: BadgeAnimationType.scale,
                    badgeContent: Text(
                      cartController.cartDetails.value.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                  ),
                ),
              );
            }))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              controller: pageController,
              isScrollable: true,
              indicatorColor: Colors.red,
              tabs: first?.tableMenuList
                      ?.map((e) => Tab(
                              child: Text(
                            e.menuCategory ?? "",
                            style: TextStyle(color: Colors.redAccent),
                          )))
                      .toList() ??
                  [],
            ),
          ),
        ),
        body: TabBarView(
          controller: pageController,
          children:
              first?.tableMenuList?.map((e) => getMenuList(e)).toList() ?? [],
        ),
      );
    });
  }
}

Widget getMenuList(TableMenuList menuList) {
  var dishes = menuList.categoryDishes ?? [];

  return ListView.builder(
    itemBuilder: (context, index) {
      var dish = dishes[index];
      if (dish == null) {
        return Text("no data");
      }
      return DishItemPage(dish);
    },
    itemCount: dishes.length,
  );
}
