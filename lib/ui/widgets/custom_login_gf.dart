import 'package:flutter/material.dart';

class CustomLoginGF extends StatelessWidget {
  final Function onTap;
  final String images;
  final TextStyle style;
  final Text text;
  final String title;

  CustomLoginGF({this.onTap, this.images, this.text, this.style, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      child: ButtonTheme(
        minWidth: 10.0,
        height: 50.0,
        child: OutlineButton(
          onPressed: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          splashColor: Colors.grey,
          borderSide: BorderSide(color: Colors.grey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    images,
                    height: 40.0,
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${this.title}',
                    style: style,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
