import 'package:flutter/material.dart';

class ColorFilter extends StatelessWidget {
  final Color? color;
  final bool isSelected;

  const ColorFilter({super.key, required this.color, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                color: color!,
              )
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: null,
        ),
      ),
    );
  }
}
