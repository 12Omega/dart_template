import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final IconData? icon;
  final bool isLoading; // Added isLoading

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.height = 50.0, // Default height
    this.borderRadius,
    this.icon,
    this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, // Default to full width
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable if loading
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0), // Default border radius
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.0,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(color: textColor ?? Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
