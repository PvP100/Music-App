import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import 'custom_loading_widget.dart';

class CustomLoading {
  factory CustomLoading() => _instance;
  static final CustomLoading _instance = CustomLoading._internal();
  static CustomLoading get instance => _instance;

  CustomLoading._internal() {
    indicatorWidget = Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 8)],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: const CircularProgressIndicator(color: AppColors.color04A63C),
    );
  }

  Widget? _w;
  Widget? get w => _w;

  Widget? indicatorWidget;

  OverlayEntry? overlayEntry;

  static Future<void> show() async {
    return instance._show();
  }

  static Future<void> showSuccess({Widget? widget}) async {
    return instance._show(widget: widget ?? Container());
  }

  static Future<void> dismiss() async {
    return instance._dismiss();
  }

  Future<void> _dismiss() async {
    _w = null;
    overlayEntry?.markNeedsBuild();
  }

  Future<void> _show({Widget? widget}) async {
    _w = Container(
        color: Colors.black.withOpacity(0.45),
        alignment: Alignment.center,
        child: widget ?? indicatorWidget);
    overlayEntry?.markNeedsBuild();
  }

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, CustomLoadingWidget(child: child));
      } else {
        return CustomLoadingWidget(child: child);
      }
    };
  }
}
