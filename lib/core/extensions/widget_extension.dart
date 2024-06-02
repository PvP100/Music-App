import 'package:flutter/cupertino.dart';

extension WidgetExtension on Widget {
  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Align align({
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) =>
      Align(
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );

  CupertinoButton onCupertinoClick(VoidCallback onClick,
      {bool hideKeyboard = true}) {
    return CupertinoButton(
      onPressed: () {
        if (hideKeyboard) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        onClick();
      },
      padding: EdgeInsets.zero,
      minSize: 0,
      child: this,
    );
  }
}
