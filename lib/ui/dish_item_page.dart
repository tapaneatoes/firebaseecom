import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebaseecom/controller/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/assets.dart';
import '../model/MenuDetails.dart';
import 'customviews/qty_button.dart';

class DishItemPage extends GetView {
  final CategoryDishes dish;

  DishItemPage(this.dish);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700),
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
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${dish.dishCalories ?? ""} Calories",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  dish.dishDescription ?? "",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Obx(() {
                                  print(
                                      "OBX ${cartController.cartDetails.value[dish.dishId!]?.value}");
                                  return QtyButton(
                                      qty: cartController.cartDetails
                                              .value[dish.dishId!]?.value ??
                                          0,
                                      changeListener: (int qty, bool isAdded) {
                                        if (qty > 0) {
                                          cartController.addToCart(dish, qty);
                                        } else if (qty == 0) {
                                          cartController.removeToCart(dish);
                                        }
                                      });
                                }),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: (dish.addonCat?.length ?? 0) > 0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Customization Available",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    flex: 6,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: dish.dishImage ?? "",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                color: Colors.greenAccent,
                              ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.do_not_disturb_alt,color: Colors.red,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
              Divider(color: Colors.grey, indent: 16, endIndent: 16)
            ],
          ),
        ),
      );
    });
  }
}

getVegNonveg(CategoryDishes dish) {
  if (dish.dishType == 1) {
    return Image.asset(
      Assets.imageNonVeg,
      width: 12,
    );
  } else {
    return Image.asset(Assets.imageVeg, width: 12);
  }
}
