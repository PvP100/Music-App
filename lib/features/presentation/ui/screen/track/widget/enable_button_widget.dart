import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class EnableButtonWidget extends StatelessWidget {
  const EnableButtonWidget({
    super.key,
    required this.onChanged,
    required this.size,
    required this.enableWidget,
    required this.disableWidget,
    required this.enable,
  });

  final VoidCallback onChanged;

  final bool enable;

  final double size;

  final String enableWidget;

  final String disableWidget;

  @override
  Widget build(BuildContext context) {
    return (enable
            ? enableWidget.loadImageAsset(height: size, width: size)
            : disableWidget.loadImageAsset(height: size, width: size))
        .onCupertinoClick(onChanged);
  }
}
