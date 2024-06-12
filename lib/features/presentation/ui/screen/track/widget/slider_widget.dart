import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    required this.onChangedEnd,
    this.height = 6,
  });

  final double sliderValue;

  final ValueChanged<double> onChanged;

  final ValueChanged<double> onChangedEnd;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: SliderTheme(
        data: SliderThemeData(
            trackHeight: height,
            trackShape: const RectangularSliderTrackShape(),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
            thumbShape: const RoundSliderThumbShape(
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
