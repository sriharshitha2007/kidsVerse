import 'package:flutter/material.dart';
import '../widgets/kid_button.dart';
import 'home_screen.dart';
import 'parent_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              const Color(0xFF6DD5ED),
              const Color(0xFF2193B0),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              top: 30,
              left: 20,
              child: Text(
                '⭐',
                style: const TextStyle(fontSize: 40),
              ),
            ),
            Positioned(
              top: 100,
              right: 30,
              child: Text(
                '☁️',
                style: const TextStyle(fontSize: 50),
              ),
            ),
            Positioned(
              bottom: 150,
              left: 40,
              child: Text(
                '🎈',
                style: const TextStyle(fontSize: 45),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 20,
              child: Text(
                '🌈',
                style: const TextStyle(fontSize: 50),
              ),
            ),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                // Title with animation
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        '🌈',
                                        style: TextStyle(fontSize: 60),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Welcome to',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                          colors: [
                                            const Color(0xFF6DD5ED),
                                            const Color(0xFF2193B0),
                                          ],
                                        ).createShader(bounds),
                                        child: const Text(
                                          'KidVerse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        '✨ A Safe Learning and Entertainment World ✨',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // Tagline
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Text(
                                    '✨ Learn • Play • Watch • Grow! ✨',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),

                                // Welcome message
                                Text(
                                  'Let\'s explore a magical world\nof stories, songs, learning and fun!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.95),
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 60),

                                // Buttons
                                KidButton(
                                  label: '👦 Enter KidVerse 👧',
                                  backgroundColor: const Color(0xFFFF6B6B),
                                  fontSize: 20,
                                  padding: 18,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const HomeScreen(),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 20),

                                KidButton(
                                  label: '👨‍👩‍👧 Parent Section',
                                  backgroundColor: const Color(0xFF4ECDC4),
                                  fontSize: 20,
                                  padding: 18,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const ParentScreen(),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
