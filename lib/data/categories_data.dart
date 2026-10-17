import 'package:flutter/material.dart';
import '../models/category_model.dart';

final List<Category> categoriesList = [
  Category(
    id: '1',
    title: 'Moral Stories',
    icon: '📖',
    color: const Color(0xFFFF6B6B),
    route: '/stories',
  ),
  Category(
    id: '2',
    title: 'Nursery Rhymes',
    icon: '🎵',
    color: const Color(0xFF4ECDC4),
    route: '/rhymes',
  ),
  Category(
    id: '3',
    title: 'Kids Cartoons',
    icon: '📺',
    color: const Color(0xFFFFE66D),
    route: '/cartoons',
  ),
  Category(
    id: '4',
    title: 'Good Habits',
    icon: '🌟',
    color: const Color(0xFF95E1D3),
    route: '/habits',
  ),
  Category(
    id: '5',
    title: 'Learn ABC',
    icon: '🔤',
    color: const Color(0xFFB19CD9),
    route: '/alphabet',
  ),
  Category(
    id: '6',
    title: 'Learn Numbers',
    icon: '🔢',
    color: const Color(0xFFFFA07A),
    route: '/numbers',
  ),
  Category(
    id: '7',
    title: 'Fun Activities',
    icon: '🎨',
    color: const Color(0xFF87CEEB),
    route: '/activities',
  ),
  Category(
    id: '8',
    title: 'Mini Quiz',
    icon: '🧩',
    color: const Color(0xFFDDA0DD),
    route: '/quiz',
  ),
];
