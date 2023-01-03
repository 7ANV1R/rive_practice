import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    return GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
      },
      onPanEnd: (details) {
        if (swipeDirection == null) {
          return;
        }
        if (swipeDirection == 'left') {
          //handle swipe left event
          log('left');
        }
        if (swipeDirection == 'right') {
          //handle swipe right event
          log('right');
        }
      },
      child: const Scaffold(
        backgroundColor: Color(0xFF313131),
        body: Center(
          child: RiveAnimation.asset(
            'assets/rive/Seasons_of_bangladesh.riv',
            fit: BoxFit.contain,
            stateMachines: ['nav_state'],
          ),
        ),
      ),
    );
  }
}
