import 'package:flutter/material.dart';

class LeftIconButton extends StatelessWidget {
  const LeftIconButton({
    required this.title,
    required this.image,
    required this.backgroundColor,
    required Function this.onClick,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget image;
  final Color backgroundColor;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onClick();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(alignment: Alignment.centerLeft, child: image),
                Align(
                    heightFactor: 1.2,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ))
              ],
            )),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(64)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                EdgeInsets.symmetric(horizontal: 16)),
            elevation: MaterialStateProperty.all<double>(2.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    side: BorderSide(color: backgroundColor, width: 0)))),
      ),
    );
  }
}
