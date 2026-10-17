import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  String _selectedAnswer = '';

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What color is the sun?',
      'emoji': '☀️',
      'options': ['🌊 Blue', '⭐ Yellow', '🌳 Green'],
      'correctAnswer': '⭐ Yellow',
    },
    {
      'question': 'Which animal says Meow?',
      'emoji': '🐱',
      'options': ['🐶 Dog', '🐱 Cat', '🦁 Lion'],
      'correctAnswer': '🐱 Cat',
    },
    {
      'question': 'How many legs does a dog have?',
      'emoji': '🐕',
      'options': ['2️⃣ Two', '4️⃣ Four', '6️⃣ Six'],
      'correctAnswer': '4️⃣ Four',
    },
    {
      'question': 'What do we eat for breakfast?',
      'emoji': '🍳',
      'options': ['🧸 Toy', '🍎 Apple', '🚗 Car'],
      'correctAnswer': '🍎 Apple',
    },
    {
      'question': 'What is the opposite of big?',
      'emoji': '📏',
      'options': ['🔥 Hot', '👶 Small', '😊 Happy'],
      'correctAnswer': '👶 Small',
    },
  ];

  void _answerQuestion(String answer) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _selectedAnswer = answer;
      if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _answered = false;
      _selectedAnswer = '';
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _answered = false;
      _selectedAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return _buildResultScreen();
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE6E6FA),
              const Color(0xFFD4B3FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  children: [
                    if (_currentQuestionIndex == 0)
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
                      )
                    else
                      const SizedBox(width: 44),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        '🧩 Mini Quiz',
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

              // Progress
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        Text(
                          'Score: $_score',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDDA0DD),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (_currentQuestionIndex + 1) / _questions.length,
                        minHeight: 8,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFDDA0DD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Question
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          question['emoji'],
                          style: const TextStyle(fontSize: 70),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Text(
                            question['question'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Options
                        ...List.generate(
                          question['options'].length,
                          (index) {
                            final option = question['options'][index];
                            final isCorrect =
                                option == question['correctAnswer'];
                            final isSelected = option == _selectedAnswer;

                            Color bgColor;
                            if (!_answered) {
                              bgColor = Colors.white;
                            } else if (isSelected && isCorrect) {
                              bgColor = const Color(0xFF95E1D3);
                            } else if (isSelected && !isCorrect) {
                              bgColor = const Color(0xFFFF6B6B);
                            } else if (isCorrect) {
                              bgColor = const Color(0xFF95E1D3);
                            } else {
                              bgColor = Colors.white;
                            }

                            return GestureDetector(
                              onTap: () => _answerQuestion(option),
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 15),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(14),
                                  border: isSelected
                                      ? Border.all(
                                          color: isCorrect
                                              ? const Color(0xFF95E1D3)
                                              : const Color(0xFFFF6B6B),
                                          width: 3,
                                        )
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  option,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF2C3E50),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Next button
                        if (_answered) ...[
                          const SizedBox(height: 20),
                          _selectedAnswer ==
                                  question['correctAnswer']
                              ? Column(
                                  children: [
                                    const Text(
                                      '🎉 Yay! You are correct! ⭐🎉',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF95E1D3),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Text(
                                      'Oops! Try again 😊',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF6B6B),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                          if (_currentQuestionIndex < _questions.length - 1)
                            GestureDetector(
                              onTap: _nextQuestion,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDDA0DD),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFDDA0DD)
                                          .withOpacity(0.3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Next Question ➡️',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: _nextQuestion,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF95E1D3),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF95E1D3)
                                          .withOpacity(0.3),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'See Results 🏆',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = ((_score / _questions.length) * 100).toStringAsFixed(0);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFE5E5),
              const Color(0xFFFFB3B3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '🏆 Quiz Complete! 🏆',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
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
                        Text(
                          'Your Score',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '$_score / ${_questions.length}',
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDDA0DD),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '$percentage%',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF95E1D3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _getResultMessage(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: _restartQuiz,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B6B).withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Try Again! 🎯',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ECDC4),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4ECDC4).withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Back to Home 🏠',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getResultMessage() {
    int percent = ((_score / _questions.length) * 100).toInt();
    if (percent == 100) {
      return '⭐ Perfect Score! You are a star! ⭐';
    } else if (percent >= 80) {
      return '🌟 Excellent! Great job! 🌟';
    } else if (percent >= 60) {
      return '👏 Good job! Keep practicing! 👏';
    } else {
      return '💪 Good try! Better luck next time! 💪';
    }
  }
}
