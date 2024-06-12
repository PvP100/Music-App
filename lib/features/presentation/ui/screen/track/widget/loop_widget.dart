import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/core.dart';

import '../../../../../../core/constants/image_constants.dart';

class LoopWidget extends StatefulWidget {
  const LoopWidget({super.key, required this.onLoopChange});

  final ValueChanged<LoopMode> onLoopChange;

  @override
  State<LoopWidget> createState() => _LoopWidgetState();
}

class _LoopWidgetState extends State<LoopWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return switch (LoopMode.values[currentIndex]) {
      LoopMode.all =>
        ImageConstants.iconLoopAll.loadImageAsset(height: 32, width: 32),
      LoopMode.one =>
        ImageConstants.iconLoopOne.loadImageAsset(height: 32, width: 32),
      LoopMode.off =>
        ImageConstants.iconRepeat.loadImageAsset(height: 32, width: 32)
    }
        .onCupertinoClick(_loopChange);
  }

  _loopChange() {
    setState(() {
      currentIndex =
          currentIndex < LoopMode.values.length - 1 ? currentIndex + 1 : 0;
    });
    widget.onLoopChange(LoopMode.values[currentIndex]);
  }
}
