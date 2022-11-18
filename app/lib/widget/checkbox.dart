import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final VoidCallback? onPressed;
  final double? iconSize;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Color? borderColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onPressed,
    this.iconSize,
    this.selectedColor,
    this.selectedIconColor,
    this.borderColor,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        width: 32,
        height: 32,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        decoration: BoxDecoration(
          boxShadow: widget.value
            ? [utils.color10BoxShadow]
            : [],
          shape: BoxShape.circle,
          gradient: widget.value
            ? utils.color10Gradient
            : null,
          border: Border.all(
            color: widget.value
              ? Colors.transparent
              : utils.overlayGrey,
            width: 2,
          ),
        ),
        child: widget.value
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 24,
            )
          : null,
      ),
    );
  }
}