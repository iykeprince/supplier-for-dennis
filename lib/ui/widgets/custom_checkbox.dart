import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

import 'custom_indicators.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  CustomCheckBox({
    Key key,
    this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: isChecked
            ? SimpleDot(
                isActive: true,
                color: CustomColor.primaryColor,
              )
            : Container(),
      ),
    );
  }
}
