import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:music_app/core/extensions/date_time_extension.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/utils/app_utils.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    bool rootNavigator = false,
    Map<String, dynamic>? arguments,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pushNamed(
        routeName,
        arguments: arguments,
      );

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
                    style: AppTextStyles.bold.copyWith(
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ).onCupertinoClick(() {
                    context.pop();
                    onDateTimeSelected(dateTime);
                  }),
                ),
                const Divider(height: 1),
                CupertinoDatePicker(
                  initialDateTime: initialDate ?? DateTime.now().onlyDate,
                  maximumDate: maxDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) => dateTime = value,
                ).expanded(),
              ],
            ),
          );
        });
  }

  showError(Exception? exception) {
    final localizations = AppLocalizations.of(this)!;
    switch (exception.runtimeType) {
      case NetWorkConnection:
        return AppUtils.showToast(localizations.noInternetConnection);
      case BadRequestError:
        return AppUtils.showToast(localizations.badRequest);
      case DataNotFoundError:
        return AppUtils.showToast(localizations.dataNotFound);
      case ServerError || InternalServerError:
        return AppUtils.showToast(localizations.serverError);
      case UnAuthorizedError:
        return AppUtils.showToast(localizations.unauthorized);
      default:
        return AppUtils.showToast(exception.toString());
    }
  }

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get bottomBarHeight =>
      kBottomNavigationBarHeight + MediaQuery.viewPaddingOf(this).bottom;
}
