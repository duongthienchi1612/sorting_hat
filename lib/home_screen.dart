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
  final _hatScaleNotifier = ValueNotifier<double>(1.0);

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
    _hatScaleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;

    // Responsive sizing
    final bool isSmallScreen = size.width < 394 || size.height < 853;
    final double titleFontSize = isSmallScreen ? 32 : 36;
    final double hatHeight = isSmallScreen ? size.height * 0.26 : size.height * 0.32;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.background_question),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: safeArea.top),
            _buildAppBar(context, textTheme, isSmallScreen),

            // App Title with enhanced styling
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isSmallScreen ? 8 : 16,
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [AppColors.goldenYellow, AppColors.mainColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  localizations.appTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge!.copyWith(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        offset: Offset(2, 2),
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Spacer that adjusts based on screen size
            SizedBox(height: isSmallScreen ? 4 : 16),

            // Icon Hat with interactive animation
            GestureDetector(
              onTapDown: (_) => _hatScaleNotifier.value = 0.95,
              onTapUp: (_) => _hatScaleNotifier.value = 1.0,
              onTapCancel: () => _hatScaleNotifier.value = 1.0,
              child: ValueListenableBuilder<double>(
                  valueListenable: _hatScaleNotifier,
                  builder: (context, scale, child) {
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        // Wobble effect
                        final double wobble = sin(_controller.value * 2 * pi) * 0.05;
                        return Transform.scale(
                          scale: scale,
                          child: Transform.rotate(
                            angle: wobble,
                            child: child,
                          ),
                        );
                      },
                      child: Image.asset(
                        ImagePath.icon_hat,
                        height: hatHeight,
                      ),
                    );
                  }),
            ),

            // Adaptive spacing
            SizedBox(height: isSmallScreen ? 12 : 20),

            // Start Button with hover effect
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, ScreenName.question),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 12 : 20,
                  horizontal: isSmallScreen ? 24 : 32,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 12 : 14,
                  horizontal: isSmallScreen ? 32 : 48,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  border: Border.all(color: AppColors.darkBrown, width: 2),
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
                    fontSize: isSmallScreen ? 18 : 20,
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

            // House logos grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 16,
                  vertical: isSmallScreen ? 4 : 8,
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: isSmallScreen ? 4 : 8,
                    crossAxisSpacing: isSmallScreen ? 4 : 8,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: ImagePath.houses.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        ImagePath.houses[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom spacing to account for safe area
            SizedBox(height: safeArea.bottom > 0 ? safeArea.bottom : (isSmallScreen ? 8 : 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TextTheme textTheme, bool isSmallScreen) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: isSmallScreen ? 12 : 16,
        ),
        child: Material(
          color: Colors.transparent,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.mainColor.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: isSmallScreen ? 250 : 280,
                        decoration: BoxDecoration(
                          gradient: AppColors.parchemntGradient,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.darkBrown, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildLanguageOption(
                              languageCode: 'en',
                              languageName: 'English',
                              textTheme: textTheme,
                              isSmallScreen: isSmallScreen,
                            ),
                            Divider(
                              color: AppColors.darkBrown.withOpacity(0.3),
                              height: 1,
                              thickness: 1,
                            ),
                            _buildLanguageOption(
                              languageCode: 'vi',
                              languageName: 'Vietnamese',
                              textTheme: textTheme,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              splashColor: AppColors.mainColor.withOpacity(0.3),
              highlightColor: AppColors.mainColor.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                child: Icon(
                  Icons.settings,
                  color: AppColors.mainColor,
                  size: isSmallScreen ? 22 : 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String languageCode,
    required String languageName,
    required TextTheme textTheme,
    required bool isSmallScreen,
  }) {
    return InkWell(
      onTap: () async {
        await _userRef.setLanguage(languageCode);
        widget.changeLanguage(languageCode);
        Navigator.pop(context);
      },
      child: Container(
        height: isSmallScreen ? 48 : 54,
        alignment: Alignment.center,
        child: Text(
          languageName,
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
            fontSize: isSmallScreen ? 16 : 18,
          ),
        ),
      ),
    );
  }
}
