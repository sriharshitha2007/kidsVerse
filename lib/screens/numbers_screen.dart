
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({Key? key}) : super(key: key);

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  final List<Map<String, String>> numbers = [
    {'num': '1', 'word': 'One', 'emoji': '🍎'},
    {'num': '2', 'word': 'Two', 'emoji': '🍎🍎'},
    {'num': '3', 'word': 'Three', 'emoji': '🍎🍎🍎'},
    {'num': '4', 'word': 'Four', 'emoji': '🍎🍎🍎🍎'},
    {'num': '5', 'word': 'Five', 'emoji': '🍎🍎🍎🍎🍎'},
    {'num': '6', 'word': 'Six', 'emoji': '🐥🐥🐥🐥🐥🐥'},
    {'num': '7', 'word': 'Seven', 'emoji': '⭐⭐⭐⭐⭐⭐⭐'},
    {'num': '8', 'word': 'Eight', 'emoji': '🐠🐠🐠🐠🐠🐠🐠🐠'},
    {'num': '9', 'word': 'Nine', 'emoji': '🎈🎈🎈🎈🎈🎈🎈🎈🎈'},
    {'num': '10', 'word': 'Ten', 'emoji': '🧸🧸🧸🧸🧸🧸🧸🧸🧸🧸'},
  ];

  void speakNumber(String word) {
    try {
      web.window.speechSynthesis.cancel();

      final utterance = web.SpeechSynthesisUtterance(word);
      utterance.lang = 'en-US';
      utterance.rate = 0.75;
      utterance.pitch = 1.1;

      web.window.speechSynthesis.speak(utterance);
    } catch (e) {
      debugPrint('Speech error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sorry! Voice is not available right now.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    web.window.speechSynthesis.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE5B4),
              Color(0xFFFFC299),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Text(
                          '👈',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        '🔢 Learn Numbers',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Tap a number and learn to count! 🔊',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),

              // Numbers list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    final item = numbers[index];
                    final number = int.parse(item['num']!);
                    final word = item['word']!;

                    return GestureDetector(
                      onTap: () => speakNumber(word),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Number display
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFFFA07A)
                                        .withValues(alpha: 0.3),
                                    const Color(0xFFFFB347)
                                        .withValues(alpha: 0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    item['num']!,
                                    style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    word,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFB85C38),
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  // Show the correct number of objects
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: List.generate(
                                      number,
                                      (i) => Text(
                                        _getEmoji(number, i),
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            // Voice button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () => speakNumber(word),
                                icon: const Icon(
                                  Icons.volume_up_rounded,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Hear the Number',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFA07A),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEmoji(int number, int index) {
    if (number <= 5) return '🍎';
    if (number == 6) return '🐥';
    if (number == 7) return '⭐';
    if (number == 8) return '🐠';
    if (number == 9) return '🎈';
    return '🧸';
  }
}
