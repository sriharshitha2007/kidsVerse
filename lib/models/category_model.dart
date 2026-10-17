import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final String icon;
  final Color color;
  final String route;

  Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
