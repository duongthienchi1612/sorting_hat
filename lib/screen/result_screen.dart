import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants.dart';
import '../dependencies.dart';
import '../preference/user_reference.dart';
import '../theme/app_colors.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  final userRef = injector.get<UserReference>();

  //animation
  late AnimationController _opacityController;
  late AnimationController _scaleController;
  late AnimationController _wobbleController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  
  bool _showHouseInfo = false;
  String _houseDescription = '';

  @override
  void initState() {
    super.initState();

    // Opacity animation
    _opacityController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut),
    );
    
    // Scale animation
    _scaleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    // Wobble animation for continuous effect
    _wobbleController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: false);

    // Start animations sequence
    _opacityController.forward();
    _scaleController.forward().then((_) {
      // Show house info after the logo appears
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _showHouseInfo = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _scaleController.dispose();
    _wobbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments! as String;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;
    
    // Responsive sizing
    final bool isSmallScreen = size.width < 340 || size.height < 600;
    final double imageSizeRatio = isSmallScreen ? 0.35 : 0.4;
    
    // Set house description
    _setHouseDescription(arg);
    
    // House-specific colors
    final houseColors = _getHouseColors(arg);
    final primaryColor = houseColors['primary'];
    final secondaryColor = houseColors['secondary'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.background_result),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              primaryColor!.withOpacity(0.1),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Content
            Column(
              children: [
                // Home button
                _buildHomeButton(
                  context, 
                  textTheme, 
                  localizations, 
                  isSmallScreen,
                ),

                Spacer(),
                
                // House crest with animations
                AnimatedBuilder(
                  animation: _wobbleController,
                  builder: (context, child) {
                    // Floating effect
                    final sineValue = sin(_wobbleController.value * 2 * pi);
                    final translateY = sineValue * (isSmallScreen ? 7 : 10);
                    
                    return Transform.translate(
                      offset: Offset(0, translateY),
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    getImagePath(arg),
                    height: size.height * imageSizeRatio,
                  ),
                ),

                SizedBox(height: 40,),
                
                // House name and description
                AnimatedOpacity(
                  opacity: _showHouseInfo ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 800),
                    transform: Matrix4.translationValues(
                      0, 
                      _showHouseInfo ? 0 : 50,
                      0,
                    ),
                    child: Column(
                      children: [
                        // House name
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [secondaryColor!, primaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            arg.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: textTheme.displayMedium!.copyWith(
                              fontSize: isSmallScreen ? 28 : 32,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  offset: Offset(2, 2),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 16),
                        
                        // House description
                        if (_showHouseInfo)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 16 : 24,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 14 : 20, 
                                vertical: isSmallScreen ? 12 : 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.mainColor.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _houseDescription,
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium!.copyWith(
                                  color: AppColors.mainColor,
                                  fontStyle: FontStyle.italic,
                                  fontSize: isSmallScreen ? 16 : 18,
                                  height: 1.3,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            
            // Particles effect - fewer particles on small screens
            ..._buildParticles(
              primaryColor, 
              particleCount: isSmallScreen ? 10 : 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(
    BuildContext context, 
    TextTheme textTheme, 
    AppLocalizations localizations,
    bool isSmallScreen,
  ) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(
          top:  MediaQuery.of(context).padding.top + 8,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.mainColor.withOpacity(0.3),
          ),
        ),
        child: IconButton(
          padding: EdgeInsets.all(8),
          iconSize: isSmallScreen ? 24 : 28,
          onPressed: () async {
            showDialog(
              context: context,
              builder: (ctx) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: isSmallScreen ? 250 : 280,
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 12 : 16,
                    ),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 16 : 20,
                          ),
                          child: Text(
                            localizations.retakeQuizTitle,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge!.copyWith(
                              color: AppColors.redBorder,
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 20 : 22,
                            ),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDialogButton(
                              onTap: () async {
                                await userRef.setStatusQuiz(StatusQuiz.inProgress);
                                await userRef.setCurrentQuestion(1);
                                Navigator.popAndPushNamed(context, ScreenName.home);
                              },
                              text: localizations.yes,
                              textTheme: textTheme,
                              isPrimary: true,
                              isSmallScreen: isSmallScreen,
                            ),
                            SizedBox(width: isSmallScreen ? 16 : 20),
                            _buildDialogButton(
                              onTap: () => Navigator.pop(ctx),
                              text: localizations.no,
                              textTheme: textTheme,
                              isPrimary: false,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: Icon(
            Icons.home,
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
  
  Widget _buildDialogButton({
    required Function() onTap,
    required String text,
    required TextTheme textTheme,
    required bool isPrimary,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 20 : 24, 
          vertical: isSmallScreen ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: isPrimary 
              ? AppColors.darkBrown.withOpacity(0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.darkBrown,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: textTheme.bodyMedium!.copyWith(
            color: isPrimary ? AppColors.mainColor : AppColors.redBorder,
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 16 : 18,
          ),
        ),
      ),
    );
  }
  
  // House-specific colors
  Map<String, Color> _getHouseColors(String house) {
    switch (house) {
      case HouseName.gryffindor:
        return {
          'primary': AppColors.gryffindorPrimary,
          'secondary': AppColors.gryffindorSecondary,
        };
      case HouseName.ravenclaw:
        return {
          'primary': AppColors.ravenclawPrimary,
          'secondary': AppColors.ravenclawSecondary,
        };
      case HouseName.hufflepuff:
        return {
          'primary': AppColors.hufflepuffPrimary,
          'secondary': AppColors.hufflepuffSecondary,
        };
      case HouseName.slytherin:
        return {
          'primary': AppColors.slytherinPrimary,
          'secondary': AppColors.slytherinSecondary,
        };
      default:
        return {
          'primary': AppColors.mainColor,
          'secondary': AppColors.darkBrown,
        };
    }
  }
  
  // Set house description based on the house
  void _setHouseDescription(String house) {
    switch (house) {
      case HouseName.gryffindor:
        _houseDescription = "Courage, bravery, nerve, and chivalry.";
        break;
      case HouseName.ravenclaw:
        _houseDescription = "Wisdom, wit, and learning.";
        break;
      case HouseName.hufflepuff:
        _houseDescription = "Hard work, patience, justice, and loyalty.";
        break;
      case HouseName.slytherin:
        _houseDescription = "Ambition, cunning, leadership, and resourcefulness.";
        break;
      default:
        _houseDescription = "";
    }
  }
  
  // Generate animated particles for background effect
  List<Widget> _buildParticles(
    Color color, {
    required int particleCount,
  }) {
    final rnd = Random();
    return List.generate(particleCount, (index) {
      final size = rnd.nextDouble() * 10 + 2;
      final x = rnd.nextDouble() * MediaQuery.of(context).size.width;
      final y = rnd.nextDouble() * MediaQuery.of(context).size.height;
      
      return Positioned(
        left: x,
        top: y,
        child: AnimatedBuilder(
          animation: _wobbleController,
          builder: (context, child) {
            final positionValue = (_wobbleController.value + (index / particleCount)) % 1.0;
            final newY = y + (sin(positionValue * 2 * pi) * 30);
            final opacity = 0.1 + (sin(positionValue * pi) * 0.6);
            
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, newY - y),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.7),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  String getImagePath(String house) {
    switch (house) {
      case HouseName.gryffindor:
        return ImagePath.gryImage;
      case HouseName.ravenclaw:
        return ImagePath.ravImage;
      case HouseName.hufflepuff:
        return ImagePath.hufImage;
      case HouseName.slytherin:
        return ImagePath.slyImage;
      default:
        return '';
    }
  }
}
