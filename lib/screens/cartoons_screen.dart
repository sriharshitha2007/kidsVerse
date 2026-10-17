import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CartoonsScreen extends StatelessWidget {
  const CartoonsScreen({Key? key}) : super(key: key);

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
    final cartoons = [
      {
        'title': 'Peppa Pig',
        'icon': '🐷',
        'url':
            'https://www.youtube.com/results?search_query=Peppa+Pig+Official',
      },
      {
        'title': 'Tom & Jerry',
        'icon': '🐱',
        'url':
            'https://www.youtube.com/results?search_query=Tom+and+Jerry+official',
      },
      {
        'title': 'Mickey Mouse',
        'icon': '🐭',
        'url':
            'https://www.youtube.com/results?search_query=Mickey+Mouse+Disney+official',
      },
      {
        'title': 'Dora Explorer',
        'icon': '👧',
        'url':
            'https://www.youtube.com/results?search_query=Dora+the+Explorer+official',
      },
      {
        'title': 'SpongeBob',
        'icon': '🧽',
        'url':
            'https://www.youtube.com/results?search_query=SpongeBob+official+Nickelodeon',
      },
      {
        'title': 'Paw Patrol',
        'icon': '🐕',
        'url':
            'https://www.youtube.com/results?search_query=PAW+Patrol+official',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF5E6),
              Color(0xFFFFE6B3),
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
                        '📺 Kids Cartoons',
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

              // Safe content badge
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF95E1D3).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF95E1D3),
                    width: 2,
                  ),
                ),
                child: const Text(
                  '✅ All content is carefully selected and safe for children!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Cartoons list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: cartoons.length,
                  itemBuilder: (context, index) {
                    final cartoon = cartoons[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
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
                      child: Row(
                        children: [
                          // Thumbnail
                          Container(
                            width: 120,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(18),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cartoon['icon'] as String,
                                style: const TextStyle(fontSize: 45),
                              ),
                            ),
                          ),

                          // Info
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cartoon['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // WATCH BUTTON
                                  ElevatedButton(
                                    onPressed: () => _openVideo(
                                      context,
                                      cartoon['url'] as String,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFFFFE66D),
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 7,
                                      ),
                                    ),
                                    child: const Text(
                                      '▶️ Watch',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Heart icon
                          const Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              '❤️',
                              style: TextStyle(fontSize: 24),
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