import 'package:flutter/material.dart';
import 'activities_screen.dart';
import '../data/categories_data.dart';
import '../widgets/category_card.dart';
import 'stories_screen.dart';
import 'rhymes_screen.dart';
import 'cartoons_screen.dart';
import 'good_habits_screen.dart';
import 'alphabet_screen.dart';
import 'numbers_screen.dart';
import 'activities_screen.dart';
import 'quiz_screen.dart';
import 'parent_screen.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _navigateToCategory(int index) {
    final List<Widget> screens = [
      const StoriesScreen(),
      const RhymesScreen(),
      const CartoonsScreen(),
      const GoodHabitsScreen(),
      const AlphabetScreen(),
      const NumbersScreen(),
       ColoringActivityScreen(),
      const QuizScreen(),
    ];

    if (index < screens.length) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => screens[index]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF9E6),
              const Color(0xFFE0F7FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with greeting
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      '👋 Hello Little Star! ⭐',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'What would you like to explore today?',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xFF7F8C8D).withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Categories grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index) {
                    final category = categoriesList[index];
                    return CategoryCard(
                      title: category.title,
                      icon: category.icon,
                      color: category.color,
                      onTap: () => _navigateToCategory(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            // Home - do nothing, already here
          } else if (index == 1) {
            // Favorites
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✨ Favorites coming soon! ✨'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (index == 2) {
            // Parent section
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ParentScreen()),
            );
          } else if (index == 3) {
            // Back to welcome
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            );
          }
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6DD5ED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 24)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('⭐', style: TextStyle(fontSize: 24)),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Text('👨‍👩‍👧', style: TextStyle(fontSize: 24)),
            label: 'Parents',
          ),
          BottomNavigationBarItem(
            icon: Text('🚪', style: TextStyle(fontSize: 24)),
            label: 'Exit',
          ),
        ],
      ),
    );
  }
}
