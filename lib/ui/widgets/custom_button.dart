import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double radius;
  final TextStyle style;
  const CustomButton({
    Key key,
    @required this.title,
    this.radius = 0.0,
    this.style,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: Center(
            child: Text(
          '${this.title}',
          style: style,
        ),),
      ),
    );
  }
}
