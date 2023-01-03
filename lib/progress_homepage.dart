import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ProgressHomePage extends StatefulWidget {
  const ProgressHomePage({super.key});

  @override
  State<ProgressHomePage> createState() => _ProgressHomePageState();
}

class _ProgressHomePageState extends State<ProgressHomePage> {
  SMIInput<double>? _indexInput;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'nav_state');
    artboard.addController(controller!);
    _indexInput = controller.findInput('index');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    return GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx > 0 ? 'left' : 'right';
      },
      onPanEnd: (details) {
        if (swipeDirection == null) {
          return;
        }
        if (swipeDirection == 'left') {
          if (_indexInput!.value > 0) {
            _indexInput?.value = _indexInput!.value - 1;
            setState(() {});
          }

          log(_indexInput!.value.toString());
          log('left');
        }
        if (swipeDirection == 'right') {
          if (_indexInput!.value < 5) {
            _indexInput?.value = _indexInput!.value + 1;
            setState(() {});
          }

          log(_indexInput!.value.toString());
          log('right');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF313131),
        body: Center(
          child: RiveAnimation.asset(
            'assets/rive/Seasons_of_bangladesh.riv',
            fit: BoxFit.contain,
            // stateMachines: const ['nav_state'],
            // controllers: [controller],
            onInit: _onRiveInit,
          ),
        ),
      ),
    );
  }
}
