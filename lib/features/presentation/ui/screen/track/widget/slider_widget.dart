import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key, required this.sliderValue, required this.onChanged});

  final ValueNotifier<double> sliderValue;

  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sliderValue,
        builder: (context, v, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SliderTheme(
              data: const SliderThemeData(
                  trackHeight: 6,
                  trackShape: RectangularSliderTrackShape(),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  )),
              child: Slider(
                value: v,
                onChanged: onChanged,
                inactiveColor: const Color(0x99D9D9D9),
                activeColor: Colors.white,
              ),
            ),
          );
        });
  }
}
