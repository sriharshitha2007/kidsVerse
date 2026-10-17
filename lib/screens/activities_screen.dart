import 'package:flutter/material.dart';

// ============================================================
// REAL DRAWING / COLORING ACTIVITY
// ============================================================

class ColoringActivityScreen extends StatefulWidget {
  const ColoringActivityScreen({Key? key}) : super(key: key);

  @override
  State<ColoringActivityScreen> createState() =>
      _ColoringActivityScreenState();
}

class _ColoringActivityScreenState
    extends State<ColoringActivityScreen> {
  final List<DrawingStroke> _strokes = [];

  Color selectedColor = Colors.red;

  double brushSize = 8.0;

  bool isEraser = false;

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.black,
  ];

  void startDrawing(Offset position) {
    setState(() {
      _strokes.add(
        DrawingStroke(
          points: [position],
          color: isEraser ? Colors.white : selectedColor,
          width: brushSize,
        ),
      );
    });
  }

  void continueDrawing(Offset position) {
    if (_strokes.isEmpty) return;

    setState(() {
      _strokes.last.points.add(position);
    });
  }

  void stopDrawing() {
    setState(() {});
  }

  void clearCanvas() {
    setState(() {
      _strokes.clear();
    });
  }

  void selectColor(Color color) {
    setState(() {
      selectedColor = color;
      isEraser = false;
    });
  }

  void activateEraser() {
    setState(() {
      isEraser = true;
    });
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
              Color(0xFFFFF5E6),
              Color(0xFFE6F7FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 18,
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
                        '🎨 Coloring Time!',
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

              const Text(
                'Draw anything you like! 🖌️',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),

              const SizedBox(height: 12),

              // ==================================================
              // TOOLBAR
              // ==================================================

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [

                    // COLORS
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: colors.map((color) {
                            final selected =
                                selectedColor == color && !isEraser;

                            return GestureDetector(
                              onTap: () => selectColor(color),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected
                                        ? Colors.black
                                        : Colors.white,
                                    width: selected ? 4 : 2,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // ERASER
                    IconButton(
                      tooltip: 'Eraser',
                      onPressed: activateEraser,
                      icon: Icon(
                        Icons.cleaning_services,
                        color: isEraser
                            ? Colors.black
                            : Colors.grey,
                        size: 28,
                      ),
                    ),

                    // CLEAR
                    IconButton(
                      tooltip: 'Clear',
                      onPressed: clearCanvas,
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ==================================================
              // BRUSH SIZE
              // ==================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(Icons.brush, size: 20),

                  SizedBox(
                    width: 220,
                    child: Slider(
                      min: 2,
                      max: 30,
                      value: brushSize,
                      onChanged: (value) {
                        setState(() {
                          brushSize = value;
                        });
                      },
                    ),
                  ),

                  Text(
                    '${brushSize.toInt()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // ==================================================
              // DRAWING CANVAS
              // ==================================================

              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(
                    15,
                    5,
                    15,
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: GestureDetector(

                      // Mouse down / finger down
                      onPanStart: (details) {
                        startDrawing(details.localPosition);
                      },

                      // Mouse moving / finger moving
                      onPanUpdate: (details) {
                        continueDrawing(details.localPosition);
                      },

                      // Mouse released / finger released
                      onPanEnd: (details) {
                        stopDrawing();
                      },

                      child: CustomPaint(
                        painter: DrawingPainter(_strokes),
                        child: Container(),
                      ),
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
}


// ============================================================
// DRAWING STROKE
// ============================================================

class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double width;

  DrawingStroke({
    required this.points,
    required this.color,
    required this.width,
  });
}


// ============================================================
// DRAWING PAINTER
// ============================================================

class DrawingPainter extends CustomPainter {
  final List<DrawingStroke> strokes;

  DrawingPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {

    for (final stroke in strokes) {

      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (stroke.points.length == 1) {

        // Draw a dot when the user just clicks once
        canvas.drawCircle(
          stroke.points.first,
          stroke.width / 2,
          paint,
        );

      } else {

        for (int i = 0; i < stroke.points.length - 1; i++) {

          canvas.drawLine(
            stroke.points[i],
            stroke.points[i + 1],
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return true;
  }
}