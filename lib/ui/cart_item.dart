import 'package:firebaseecom/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/assets.dart';
import '../model/MenuDetails.dart';
import 'customviews/qty_button.dart';

class CartItem extends GetView {
  final CategoryDishes dish;
  int qty = 0;

  CartItem(this.dish, this.qty);

  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                child: getVegNonveg(dish),
              ),
              flex: 1,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          dish.dishName ?? "",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${dish.dishCurrency ?? ""} ${dish.dishPrice ?? ""}",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${dish.dishCalories ?? ""} Calories",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              flex: 3,
            ),
            QtyButton(
                qty: qty,
                changeListener: (int qty, bool isAdded) {
                  print(qty);
                  if (qty > 0) {
                    cartController.addToCart(dish, qty);
                  } else if (qty == 0) {
                    cartController.removeToCart(dish);
                  }
                }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "${dish.dishCurrency} ${(qty.toDouble() * (dish.dishPrice ?? 1.0)).toStringAsFixed(2)}"),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
    ;
  }
}

getVegNonveg(CategoryDishes dish) {
  if (dish.dishType == 1) {
    return Image.asset(
      Assets.imageNonVeg,
      width: 16,
    );
  } else {
    return Image.asset(Assets.imageVeg, width: 16);
  }
}
