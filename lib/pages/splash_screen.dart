import 'package:fluent/res/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final String _brandText = "FLUENT";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_brandText.length, (index) {
            return AnimatedLetter(
              letter: _brandText[index],
              index: index,
              totalLetters: _brandText.length,
              controller: _controller,
            );
          }),
        ),
      ),
    );
  }
}

class AnimatedLetter extends StatelessWidget {
  final String letter;
  final int index;
  final int totalLetters;
  final AnimationController controller;

  AnimatedLetter({
    required this.letter,
    required this.index,
    required this.totalLetters,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the start and end of this specific letter's animation
    final double start = (index / totalLetters) * 0.5;
    final double end = start + 0.5;

    final Animation<double> opacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
        );

    final Animation<Offset> offset =
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: FractionalTranslation(
            translation: offset.value,
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
          ),
        );
      },
    );
  }
}
