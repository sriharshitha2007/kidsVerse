
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/habits_data.dart';
import '../widgets/habit_card.dart';

class GoodHabitsScreen extends StatefulWidget {
  const GoodHabitsScreen({Key? key}) : super(key: key);

  @override
  State<GoodHabitsScreen> createState() => _GoodHabitsScreenState();
}

class _GoodHabitsScreenState extends State<GoodHabitsScreen> {
  int? _expandedHabitId;

  // Video links for each habit.
  final Map<String, String> habitVideos = {
    'Wash Hands Before Eating':
        'https://www.youtube.com/watch?v=IMQBumkdQR0',

    'Brush Your Teeth':
        'https://www.youtube.com/watch?v=cwexefzhWHY',

    'Keep Toys Neatly':
        'https://www.youtube.com/results?search_query=put+toys+away+song+for+kids',

    'Say Please and Thank You':
        'https://www.youtube.com/results?search_query=please+and+thank+you+manners+song+for+kids',

    'Throw Waste in Dustbin':
        'https://www.youtube.com/results?search_query=put+trash+in+the+bin+song+for+kids',

    'Eat Healthy Food':
        'https://www.youtube.com/results?search_query=healthy+food+song+for+kids',

    'Respect Parents and Teachers':
        'https://www.youtube.com/results?search_query=respect+parents+and+teachers+for+kids',

    'Make Your Bed':
        'https://www.youtube.com/results?search_query=make+your+bed+song+for+kids',
  };

  // Open the video for the selected habit.
  Future<void> _watchVideo(String habitTitle) async {
    final title = habitTitle.trim();

    // Match habit names without being affected by uppercase/lowercase.
    String? videoUrl;

    for (final entry in habitVideos.entries) {
      if (entry.key.trim().toLowerCase() == title.toLowerCase()) {
        videoUrl = entry.value;
        break;
      }
    }

    if (videoUrl == null) {
      debugPrint('No video link found for: "$title"');
      debugPrint('Available video titles: ${habitVideos.keys.toList()}');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No video link added for "$title".'),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    final uri = Uri.tryParse(videoUrl);

    if (uri == null || !uri.hasScheme) {
      debugPrint('Invalid video URL: $videoUrl');
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open the video link.'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error opening video: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open the video link.'),
        ),
      );
    }
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
              Color(0xFFE0FFE0),
              Color(0xFFB3FFB3),
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
                        '🌟 Good Habits',
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

              // Habits list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: habitsList.length,
                  itemBuilder: (context, index) {
                    final habit = habitsList[index];
                    final habitId = int.parse(habit.id);
                    final isExpanded = _expandedHabitId == habitId;

                    return Column(
                      children: [
                        HabitCard(
                          icon: habit.icon,
                          title: habit.title,
                          description: habit.description,
                          onTap: () {
                            setState(() {
                              _expandedHabitId =
                                  isExpanded ? null : habitId;
                            });
                          },
                        ),

                        if (isExpanded)
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.cyan.withOpacity(0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Steps
                                const Text(
                                  '📋 Steps:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                ...List.generate(
                                  habit.steps.length,
                                  (stepIndex) => Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${stepIndex + 1}. ',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            habit.steps[stepIndex],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF2C3E50),
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Importance
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF95E1D3)
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF95E1D3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        '⭐',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          habit.importance,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2C3E50),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // Action buttons
                                Row(
                                  children: [
                                    // Watch Video
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _watchVideo(habit.title);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4ECDC4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            '🎥 Watch Video',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    // Done button
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Great job! ⭐ Keep practicing this habit!',
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF95E1D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text(
                                            '✅ Done!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
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
