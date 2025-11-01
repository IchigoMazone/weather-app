
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final bool isMenu;

  const ActionButton({
    super.key,
    this.icon,
    required this.onTap,
    this.isMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.2),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.2),
        ),
        child: Center(
          child: isMenu
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (_) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.2),
                      width: 5.5,
                      height: 5.5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              : Icon(icon, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}