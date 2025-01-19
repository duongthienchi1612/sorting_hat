import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';
import 'dependencies.dart';
import 'preference/user_reference.dart';
import 'theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _userRef = injector.get<UserReference>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(ImagePath.background_question), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(height: 54),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 18,
                child: IconButton(
                    padding: EdgeInsets.only(right: 16),
                    iconSize: 24,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return Dialog(
                            backgroundColor: AppColors.mainColor,
                            child: SizedBox(
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () async {
                                        await _userRef.setLanguage('en');
                                        widget.changeLanguage('en');
                                        Navigator.pop(ctx);
                                      },
                                      child: Text(
                                        'English',
                                        style: textTheme.bodyMedium!.copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () async {
                                        await _userRef.setLanguage('vi');
                                        widget.changeLanguage('vi');
                                        Navigator.pop(ctx);
                                      },
                                      child: Text(
                                        'Vietnamese',
                                        style: textTheme.bodyMedium!.copyWith(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ),
            ),
            Text(
              localizations.appTitle,
              style: textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
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
                    final double wobble = sin(_controller.value * 2 * pi) * 0.05;
                    return Transform.rotate(
                      angle: wobble,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    ImagePath.icon_hat,
                    height: MediaQuery.of(context).size.height * 0.3, // Flexible height
                  )),
            ),
            const SizedBox(height: 16),
            // Button start
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, ScreenName.question),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
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
                child: Text(
                  localizations.startQuiz,
                  style: textTheme.labelLarge!.copyWith(
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
