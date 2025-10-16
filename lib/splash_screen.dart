import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/root.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _visible = false;
  bool _scaled = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));

    // Trigger animations with delays
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _visible = true);
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() => _scaled = true);
      _controller.forward();
    });


    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const Root()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(280),
                AnimatedOpacity(
                  opacity: _visible ? 1 : 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                  child: AnimatedScale(
                    scale: _scaled ? 1 : 0.7,
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeOutBack,
                    child: SvgPicture.asset(
                      'assets/logo/logo.svg',
                      height: 100,
                    ),
                  ),
                ),
                const Spacer(),
                SlideTransition(
                  position: _slideAnimation,
                  child: Image.asset('assets/splash/splash2.png', height: 220),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
