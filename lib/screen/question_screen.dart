import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/question/question_bloc.dart';
import '../constants.dart';
import '../dependencies.dart';
import '../theme/app_colors.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with SingleTickerProviderStateMixin {
  final _bloc = injector.get<QuestionBloc>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int? _selectedAnswerIndex;
  final Map<String, bool> _imagesLoaded = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index, Function() onSelect) {
    setState(() {
      _selectedAnswerIndex = index;
    });

    // Delay to show selection effect before proceeding
    Future.delayed(const Duration(milliseconds: 500), () {
      onSelect();
      // Reset animation for next question with smooth transition
      _animationController.reset();
      _animationController.forward();
      setState(() {
        _selectedAnswerIndex = null;
      });
    });
  }

  // Preload images to prevent flashing
  Future<void> _preloadImages(List<String> imagePaths) async {
    for (final path in imagePaths) {
      if (_imagesLoaded[path] != true) {
        await precacheImage(AssetImage('assets/images/$path'), context);
        _imagesLoaded[path] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;

    return BlocProvider(
      create: (context) => _bloc..add(LoadData()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocConsumer<QuestionBloc, QuestionState>(
          listener: (context, state) {
            if (state is QuestionLoaded) {
              if (StringUtils.isNotNullOrEmpty(state.houseName)) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ScreenName.result,
                  (route) => false,
                  arguments: state.houseName,
                );
              } else if (state.data != null) {
                // Preload images for alternative questions
                final question = state.data!.question;
                if (question.type == QuestionType.alternative) {
                  final imagePaths = state.data!.answers.map((answer) => answer.imagePath!).toList();
                  _preloadImages(imagePaths);
                }
              }
            }
          },
          builder: (context, state) {
            if (state is QuestionLoaded) {
              if (state.data != null) {
                final question = state.data!.question;
                // Question with 2 option (image-based)
                if (question.type == QuestionType.alternative) {
                  final imagePaths = state.data!.answers.map((answer) => answer.imagePath!).toList();

                  return FutureBuilder(
                    future: _preloadImages(imagePaths),
                    builder: (context, snapshot) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background image
                          Image.asset(
                            ImagePath.background_question,
                            fit: BoxFit.cover,
                            cacheHeight: 1200,
                          ),
                          // Content
                          Column(
                            children: [
                              ...List.generate(state.data!.answers.length, (index) {
                                final answer = state.data!.answers[index];
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => _selectAnswer(
                                      index,
                                      () => _bloc.add(
                                        SelectAnswer(
                                          currentQuestionId: state.data!.currentQuestionId,
                                          gryPoint: answer.gryPoint!,
                                          ravPoint: answer.ravPoint!,
                                          hufPoint: answer.hufPoint!,
                                          slyPoint: answer.slyPoint!,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: _selectedAnswerIndex == index
                                            ? Border.all(color: AppColors.brightYellow, width: 4)
                                            : null,
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/${answer.imagePath!}'),
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // Overlay khi được chọn
                                          if (_selectedAnswerIndex == index)
                                            Container(
                                              color: Colors.yellow.withOpacity(0.15),
                                            ),
                                          // Text
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: _selectedAnswerIndex == index
                                                      ? AppColors.brightYellow.withOpacity(0.7)
                                                      : AppColors.mainColor.withOpacity(0.7),
                                                  width: _selectedAnswerIndex == index ? 2 : 1,
                                                ),
                                              ),
                                              child: Text(
                                                answer.answerText!,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                                  fontSize: size.width < 340 ? 24 : 30,
                                                  shadows: [
                                                    Shadow(offset: Offset(-1.5, -1.5)),
                                                    Shadow(offset: Offset(1.5, -1.5)),
                                                    Shadow(offset: Offset(1.5, 1.5)),
                                                    Shadow(offset: Offset(-1.5, 1.5)),
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
                              }),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }

                // Question with multiple text options
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background image
                    Image.asset(
                      ImagePath.background_question,
                      fit: BoxFit.cover,
                    ),
                    // Content
                    SafeArea(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            children: [
                              // Top area
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${state.data!.currentQuestionId.toString()} / ${state.data!.totalQuestion}',
                                    style: textTheme.bodySmall,
                                  ),
                                ),
                              ),

                              // Content area - make it scrollable if needed
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return SingleChildScrollView(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: constraints.maxHeight,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Question text
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 16),
                                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(0.6),
                                                      Colors.black.withOpacity(0.4),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: AppColors.mainColor.withOpacity(0.5),
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  question.questionText!,
                                                  textAlign: TextAlign.center,
                                                  style: textTheme.bodyLarge!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: size.width < 340 ? 20 : 24,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 6,
                                                        offset: Offset(2, 2),
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Answers
                                              ...List.generate(
                                                state.data!.answers.length,
                                                (index) {
                                                  final answer = state.data!.answers[index];
                                                  final isSelected = _selectedAnswerIndex == index;

                                                  return TweenAnimationBuilder<double>(
                                                    tween: Tween<double>(begin: 0.0, end: 1.0),
                                                    duration: Duration(milliseconds: 500 + (index * 100)),
                                                    curve: Curves.easeOutQuad,
                                                    builder: (context, value, child) {
                                                      return Transform.translate(
                                                        offset: Offset(0, 20 * (1 - value)),
                                                        child: Opacity(
                                                          opacity: value,
                                                          child: child,
                                                        ),
                                                      );
                                                    },
                                                    child: GestureDetector(
                                                      onTap: () => _selectAnswer(
                                                        index,
                                                        () => _bloc.add(
                                                          SelectAnswer(
                                                            currentQuestionId: state.data!.currentQuestionId,
                                                            gryPoint: answer.gryPoint!,
                                                            ravPoint: answer.ravPoint!,
                                                            hufPoint: answer.hufPoint!,
                                                            slyPoint: answer.slyPoint!,
                                                          ),
                                                        ),
                                                      ),
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 300),
                                                        width: double.infinity,
                                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: size.width < 340 ? 12 : 14,
                                                          horizontal: size.width < 340 ? 16 : 24,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: isSelected
                                                                ? [
                                                                    AppColors.brightYellow.withOpacity(0.9),
                                                                    AppColors.mainColor
                                                                  ]
                                                                : [
                                                                    AppColors.mainColor,
                                                                    AppColors.mainColor.withOpacity(0.8)
                                                                  ],
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                          ),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? AppColors.brightYellow
                                                                : AppColors.darkBrown,
                                                            width: isSelected ? 2.5 : 2,
                                                          ),
                                                          borderRadius: BorderRadius.circular(25),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: isSelected ? 15 : 10,
                                                              color: Colors.black.withOpacity(isSelected ? 0.5 : 0.4),
                                                              offset: const Offset(2, 4),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          answer.answerText!,
                                                          textAlign: TextAlign.center,
                                                          style: textTheme.bodyMedium!.copyWith(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                isSelected ? FontWeight.bold : FontWeight.normal,
                                                            fontSize: size.width < 340 ? 16 : 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              // Add bottom padding
                                              SizedBox(height: 20 + safeArea.bottom),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            }
            // Loading state
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.background_question),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
