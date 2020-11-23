import 'package:flutter/material.dart';

class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
        );
  }
}