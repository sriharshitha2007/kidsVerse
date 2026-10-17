import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String emoji;
  final Color? color;

  const SectionTitle({
    Key? key,
    required this.title,
    required this.emoji,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color ?? const Color(0xFF2C3E50),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
