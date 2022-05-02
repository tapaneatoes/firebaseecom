import 'package:firebaseecom/controller/CartController.dart';
import 'package:firebaseecom/model/MenuDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'cart_item.dart';

class CartPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.black54),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: GetBuilder<CartController>(builder: (controller) {
          var catSize = controller.cartDetails.value.length;
          return ElevatedButton(
            onPressed: () {
              if (catSize > 0) {
                Get.snackbar("Congratulations", "Order Placed successfully!",
                    backgroundColor: Colors.green, colorText: Colors.white);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    catSize > 0 ? Colors.green : Colors.grey),
                minimumSize:
                    MaterialStateProperty.all<Size>(Size.fromHeight(48)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                    EdgeInsets.symmetric(horizontal: 8)),
                elevation: MaterialStateProperty.all<double>(2.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: BorderSide(
                            color: catSize > 0 ? Colors.green : Colors.grey,
                            width: 0)))),
            child: Text(
              'Place Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          );
        }),
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        return SingleChildScrollView(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Wrap(
              children: [
                Column(
                  children: [
                    CartTitle(
                        dishes: controller.cartDetails.value.length.toString(),
                        items: controller.getTotalItem().toString()),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: getListItem(controller.cartDetails.value),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  getListItem(Map<String, MapEntry<CategoryDishes, int>> value) {
    List<Widget> widgets = List.empty(growable: true);
    value.forEach((key, value) {
      widgets.add(CartItem(value.key, value.value));
      widgets.add(Divider(
        color: Colors.grey,
        indent: 16,
        endIndent: 16,
        height: 1,
      ));
    });
    widgets.add(getTotalView(value));

    return widgets;
  }

  Widget getTotalView(Map<String, MapEntry<CategoryDishes, int>> value) {
    double total = 0.0;
    String currency = "";
    value.forEach((key, value) {
      currency = value.key.dishCurrency ?? "";
      total = total + ((value.key.dishPrice ?? 0) * value.value);
    });
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            "Total Amount",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            "${currency}  ${total.toStringAsFixed(2)}",
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 18,
                color: Colors.lightGreen,
                fontWeight: FontWeight.w500),
          ),
        )),
      ],
    );
  }
}

class CartTitle extends StatelessWidget {
  final String dishes;
  final String items;

  const CartTitle({required this.dishes, required this.items, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            color: Colors.green,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "${dishes} Dishes - ${items} Items",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ))
      ],
    );
  }
}
