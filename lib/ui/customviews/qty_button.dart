import 'package:flutter/material.dart';

class QtyButton extends StatelessWidget {
  final Function changeListener;
  final int qty;

  const QtyButton({required this.changeListener, required this.qty, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (qty > 1) {
                  print("remove ${qty}");
                  changeListener((qty - 1), false);
                } else {
                  changeListener(0, false);
                }
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text(qty.toString(), style: TextStyle(color: Colors.white)),
            SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                changeListener(qty+1, true);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
