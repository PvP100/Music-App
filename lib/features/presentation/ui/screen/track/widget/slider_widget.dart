import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final ValueNotifier<double> _sliderValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _sliderValue,
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

  onChanged(double value) {
    _sliderValue.value = value;
  }
}
