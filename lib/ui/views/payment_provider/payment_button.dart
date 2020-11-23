import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentButton extends StatelessWidget {
  final Image image;
  final Widget text;
  final Color color;
  final Function onTap;
  PaymentButton({this.image, this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: image),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: color,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: text,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
