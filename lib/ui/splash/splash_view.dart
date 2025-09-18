import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _iconController;
  late final Animation<Offset> _iconSlideAnimation;

  late final AnimationController _logoController;
  late final AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // --- ICON SLIDE CONTROLLER ---
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _iconSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.29, 0), // Move slightly left
    ).animate(CurvedAnimation(parent: _iconController, curve: Curves.easeOut));

    // --- LOGO FADE CONTROLLER ---
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // --- SUBTEXT FADE CONTROLLER ---
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _iconController.forward();
    _logoController.forward();

    // Start text fade when logo is done
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textController.forward();
      }
    });

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAllNamed(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // --- ICON (Only Slide Left) ---
                SlideTransition(
                  position: _iconSlideAnimation,
                  child: Image.asset(
                    'assets/images/boozin_icon.png',
                    width: 180,
                  ),
                ),

                FadeTransition(
                  opacity: _logoController,
                  child: isDark
                      ? Image.asset(
                          'assets/images/boozin_logo_dark.png',
                          width: 180,
                        )
                      : Image.asset(
                          'assets/images/boozin_logo2.png',
                          width: 180,
                        ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: FadeTransition(
                    opacity: _textController,
                    child: Text(
                      "Fitness",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),

            // --- SUBTEXT (Fade In After Logo) ---
          ],
        ),
      ),
    );
  }
}
