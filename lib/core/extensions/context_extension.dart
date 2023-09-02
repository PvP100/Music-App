import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(result);
  }

  void pushNamed(
    String routeName, {
    bool rootNavigator = false,
    Map<String, dynamic>? arguments,
  }) {
    Navigator.of(this, rootNavigator: rootNavigator).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void showDatePicker(Function(DateTime date) onDateTimeSelected,
      {DateTime? initialDate, DateTime? maxDate}) {
    showCupertinoModalPopup(
        context: this,
        builder: (context) {
          DateTime dateTime = DateTime.now();
          return Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    AppLocalizations.of(this)!.done,
                    style: TextStyleConstants.bold.copyWith(
                      color: ColorConstants.primary,
                      fontSize: 18,
                    ),
                  ).onCupertinoClick(() {
                    context.pop();
                    onDateTimeSelected(dateTime);
                  }),
                ),
                const Divider(height: 1),
                CupertinoDatePicker(
                  initialDateTime: initialDate ??
                      DateTime.now().copyWith(
                        hour: 0,
                        millisecond: 0,
                        second: 0,
                        minute: 0,
                        microsecond: 0,
                      ),
                  maximumDate: maxDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) => dateTime = value,
                ).expanded(),
              ],
            ),
          );
        });
  }

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get bottomBarHeight =>
      kBottomNavigationBarHeight + MediaQuery.viewPaddingOf(this).bottom;
}
