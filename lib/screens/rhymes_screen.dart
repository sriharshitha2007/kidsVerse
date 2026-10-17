import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RhymesScreen extends StatelessWidget {
  const RhymesScreen({Key? key}) : super(key: key);

  Future<void> _openVideo(BuildContext context, String url) async {
    final uri = Uri.parse(url);

    if (await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      return;
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the video'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rhymes = [
      {
        'title': 'Twinkle Twinkle Little Star',
        'icon': '⭐',
        'url': 'https://www.youtube.com/watch?v=yCjJyiqpAuU',
      },
      {
        'title': 'Baby Shark',
        'icon': '🦈',
        'url': 'https://www.youtube.com/results?search_query=Baby+Shark+Pinkfong',
      },
      {
        'title': 'Johny Johny Yes Papa',
        'icon': '👦',
        'url': 'https://www.youtube.com/watch?v=F4tHL8reNCs',
      },
      {
        'title': 'Wheels on the Bus',
        'icon': '🚌',
        'url': 'https://www.youtube.com/watch?v=e_04ZrNroTo',
      },
      {
        'title': 'Mary Had a Little Lamb',
        'icon': '🐑',
        'url': 'https://www.youtube.com/watch?v=A5aVT7ctVGU',
      },
      {
        'title': 'Baa Baa Black Sheep',
        'icon': '🐑',
        'url': 'https://www.youtube.com/watch?v=MR5XSOdjKMA',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F7FF),
              Color(0xFFB3E5FC),
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
                              color: Colors.black.withOpacity(0.1),
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
                        '🎵 Nursery Rhymes',
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

              // Rhymes grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: rhymes.length,
                  itemBuilder: (context, index) {
                    final rhyme = rhymes[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            rhyme['icon'] as String,
                            style: const TextStyle(fontSize: 50),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            rhyme['title'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // PLAY BUTTON
                          ElevatedButton(
                            onPressed: () => _openVideo(
                              context,
                              rhyme['url'] as String,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4ECDC4),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                            ),
                            child: const Text(
                              '▶️ Play',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
}