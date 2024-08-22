import 'dart:async';

import 'package:drive_mate_real/page/login.dart';
import 'package:drive_mate_real/page/main/home.dart';
import 'package:flutter/material.dart';
import 'package:drive_mate_real/utils/pallete.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  String _displayText = '';
  final String _fullText = 'Welcome to';
  int _currentIndex = 0;
  Timer? _timer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _typingAnimation();

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  void _typingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentIndex < _fullText.length) {
        setState(() {
          _displayText += _fullText[_currentIndex];
          _currentIndex++;
        });
      } else {
        _timer?.cancel();

        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Palette.splashBackground.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 1200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _isVisible
                    ? Text(_displayText,
                        key: const ValueKey('text1'),
                        style: theme.textTheme.titleLarge?.apply(
                          color: Palette.main.color,
                          fontWeightDelta: 4,
                          fontSizeDelta: 16,
                        ))
                    : Text('Drive Mate',
                        key: const ValueKey('text2'),
                        style: theme.textTheme.titleLarge?.apply(
                          color: Palette.main.color,
                          fontWeightDelta: 4,
                          fontSizeDelta: 16,
                        )))
          ],
        ),
      ),
    );
  }
}
