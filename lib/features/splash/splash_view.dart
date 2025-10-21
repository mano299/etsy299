import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:etsy/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final Animation<double> _introScale;
  late final Animation<double> _introRotate;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _introScale = Tween<double>(begin: 0.6, end: 1.05).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutBack),
    );

    _introRotate = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: -0.08, end: 0.08)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 60),
      TweenSequenceItem(
          tween: Tween(begin: 0.08, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 40),
    ]).animate(_introController);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _introController.forward();

    Future.delayed(const Duration(milliseconds: 4200), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ProfileView()));
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color glowColor = const Color(0xFFB8860B);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_introController, _pulseController]),
            builder: (context, child) {
              final double pulseFactor = 0.02 * _pulseAnim.value;
              final double scale = _introScale.value * (1 + pulseFactor);
              final double glow = (0.35 + 0.65 * _pulseAnim.value) *
                  (_introController.value.clamp(0.0, 1.0));
              final double rotation =
                  _introRotate.value * (1.0 - (_pulseAnim.value * 0.08));

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0, 0.0)
                      ..rotateZ(rotation)
                      ..scale(scale, scale),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: glowColor.withOpacity(0.18 * glow),
                            blurRadius: 40 * glow,
                            spreadRadius: 6 * glow,
                          ),
                          BoxShadow(
                            color: glowColor.withOpacity(0.10 * glow),
                            blurRadius: 120 * glow,
                            spreadRadius: 24 * glow,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          'assets/images/etsySplash.png',
                          width: 240,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Opacity(
                    opacity: (_introController.value > 0.25)
                        ? ((_introController.value - 0.25) / 0.75)
                            .clamp(0.0, 1.0)
                        : 0.0,
                    child: Transform.translate(
                      offset: Offset(
                          0,
                          20 * (1 - _introController.value) -
                              6 * _pulseAnim.value),
                      child: Transform.scale(
                        scale: 1.0 + 0.015 * _pulseAnim.value,
                        child: Column(
                          children: const [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Etsy ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                Text(
                                  'Shop',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'e-commerce',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
