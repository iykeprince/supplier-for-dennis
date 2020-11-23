import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class BorderedDot extends StatelessWidget {
  final Color color;
  final double width;
  const BorderedDot({
    Key key,
    this.color = Colors.white,
    this.width = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: width,
          color: color,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SimpleDot(
          isActive: true,
          color: color == CustomColor.primaryColor
              ? CustomColor.primaryColor
              : Colors.white,
        ),
      ),
    );
  }
}

class SimpleDot extends StatelessWidget {
  final bool isActive;
  final Color color;
  final double dotSize;
  const SimpleDot({
    Key key,
    this.isActive = false,
    this.color = Colors.white,
    this.dotSize = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color == CustomColor.primaryColor
            ? isActive ? CustomColor.primaryColor : Colors.pink.shade300
            : isActive ? Colors.white : Colors.white38,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SimpleLine extends StatelessWidget {
  final Color color;
  const SimpleLine({
    Key key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 1,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}
