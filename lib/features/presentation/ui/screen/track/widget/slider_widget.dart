import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    required this.onChangedEnd,
  });

  final double sliderValue;

  final ValueChanged<double> onChanged;

  final ValueChanged<double> onChangedEnd;

  @override
  Widget build(BuildContext context) {
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
          value: sliderValue,
          onChanged: onChanged,
          onChangeEnd: onChangedEnd,
          inactiveColor: const Color(0x99D9D9D9),
          activeColor: Colors.white,
        ),
      ),
    );
  }
}
