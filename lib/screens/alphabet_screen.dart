
import 'package:flutter/material.dart';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({Key? key}) : super(key: key);

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  final List<Map<String, String>> alphabets = [
    {'letter': 'A', 'word': 'Apple', 'emoji': '🍎'},
    {'letter': 'B', 'word': 'Ball', 'emoji': '🏀'},
    {'letter': 'C', 'word': 'Cat', 'emoji': '🐱'},
    {'letter': 'D', 'word': 'Dog', 'emoji': '🐶'},
    {'letter': 'E', 'word': 'Elephant', 'emoji': '🐘'},
    {'letter': 'F', 'word': 'Fish', 'emoji': '🐠'},
    {'letter': 'G', 'word': 'Giraffe', 'emoji': '🦒'},
    {'letter': 'H', 'word': 'House', 'emoji': '🏠'},
    {'letter': 'I', 'word': 'Ice Cream', 'emoji': '🍦'},
    {'letter': 'J', 'word': 'Jellyfish', 'emoji': '🪼'},
    {'letter': 'K', 'word': 'Kite', 'emoji': '🪁'},
    {'letter': 'L', 'word': 'Lion', 'emoji': '🦁'},
    {'letter': 'M', 'word': 'Monkey', 'emoji': '🐵'},
    {'letter': 'N', 'word': 'Nest', 'emoji': '🪺'},
    {'letter': 'O', 'word': 'Orange', 'emoji': '🍊'},
    {'letter': 'P', 'word': 'Penguin', 'emoji': '🐧'},
    {'letter': 'Q', 'word': 'Queen', 'emoji': '👑'},
    {'letter': 'R', 'word': 'Rainbow', 'emoji': '🌈'},
    {'letter': 'S', 'word': 'Sun', 'emoji': '☀️'},
    {'letter': 'T', 'word': 'Tiger', 'emoji': '🐯'},
    {'letter': 'U', 'word': 'Umbrella', 'emoji': '☂️'},
    {'letter': 'V', 'word': 'Violin', 'emoji': '🎻'},
    {'letter': 'W', 'word': 'Whale', 'emoji': '🐋'},
    {'letter': 'X', 'word': 'Xylophone', 'emoji': '🎵'},
    {'letter': 'Y', 'word': 'Yo-yo', 'emoji': '🪀'},
    {'letter': 'Z', 'word': 'Zebra', 'emoji': '🦓'},
  ];

  void speakAlphabet(String letter, String word) {
    try {
      web.window.speechSynthesis.cancel();

      final utterance =
          web.SpeechSynthesisUtterance('$letter for $word');

      utterance.lang = 'en-US';
      utterance.rate = 0.8;
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
              Color(0xFFE6D7FF),
              Color(0xFFD4B3FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF54258A),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        '🔤 Learn ABC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF54258A),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Tap any letter to hear it! 🔊',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF54258A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: alphabets.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final item = alphabets[index];
                    final letter = item['letter']!;
                    final word = item['word']!;
                    final emoji = item['emoji']!;

                    return GestureDetector(
                      onTap: () => speakAlphabet(letter, word),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFB58AE8),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.12),
                              blurRadius: 7,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              emoji,
                              style: const TextStyle(fontSize: 34),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              letter,
                              style: const TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7B3FC6),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                word,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF54258A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Icon(
                              Icons.volume_up_rounded,
                              color: Color(0xFF9B65D6),
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF8E55C7),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  '🔊 Tap a letter and say it aloud!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
