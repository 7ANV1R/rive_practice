import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class CustomHomePage extends StatefulWidget {
  const CustomHomePage({super.key});

  @override
  State<CustomHomePage> createState() => _CustomHomePageState();
}

class _CustomHomePageState extends State<CustomHomePage> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _indexInput;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/rive/Seasons_of_bangladesh.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'nav_state');
        if (controller != null) {
          artboard.addController(controller);
          _indexInput = controller.findInput('index');
          log(_indexInput!.value.toString());
          setState(() {});
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    return Scaffold(
      backgroundColor: const Color(0xFF313131),
      appBar: AppBar(
        title: const Text('Button State Machine'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
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
                    }

                    log(_indexInput!.value.toString());
                    log('left');
                  }
                  if (swipeDirection == 'right') {
                    if (_indexInput!.value < 5) {
                      _indexInput?.value = _indexInput!.value + 1;
                    }

                    log(_indexInput!.value.toString());
                    log('right');
                  }
                },
                child: Rive(
                  artboard: _riveArtboard!,
                ),
              ),
      ),
    );
  }
}
