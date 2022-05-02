import 'dart:collection';

import 'package:firebaseecom/model/MenuDetails.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<Map<String, MapEntry<CategoryDishes, int>>> cartDetails =
      new Rx(HashMap());

  void addToCart(CategoryDishes dishes, int qty) {
    var dishId = dishes.dishId;
    if (dishId != null) {
      cartDetails.value[dishId] =
          new MapEntry<CategoryDishes, int>(dishes, qty);
      cartDetails.refresh();
      update();
      print("addToCart");
      print(cartDetails.value[dishes.dishId].toString());
    }
  }

  void removeToCart(CategoryDishes dishes) {
    var dishId = dishes.dishId;
    if (dishId != null) {
      cartDetails.value.remove(dishId);
      cartDetails.update((val) {
        cartDetails.value;
      });
      cartDetails.refresh();
      update();
      print("removeToCart");
      print(cartDetails.value[dishes.dishId].toString());
    }
  }

  int getTotalItem() {
    int total = 0;
    cartDetails.value.forEach((key, value) {
      total += value.value;
    });
    return total;
  }
}
