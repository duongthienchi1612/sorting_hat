import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sorting_hat/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black, 
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background_question.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            // Title
            const SizedBox(
              height: 64,
            ),
            const Text(
              "SORTING QUIZ",
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBE4C5),
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            // Icon Mũ
            Flexible(
              flex: 4,
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    // Wobble effect
                    double wobble = sin(_controller.value * 2 * pi) * 0.05;
                    return Transform.rotate(
                      angle: wobble,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/images/icon_hat.png',
                    height: MediaQuery.of(context).size.height * 0.3, // Flexible height
                  )),
            ),
            const SizedBox(height: 16),
            // Button start
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/question'),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE4C5),
                  border: Border.all(color: const Color(0xFF6E4B3A), width: 2),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "START QUIZ",
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B2C25),
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  // childAspectRatio: screenWidth / (screenWidth * 0.5),
                  childAspectRatio: 1.5,
                ),
                itemCount: ImagePath.houses.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    ImagePath.houses[index],
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
