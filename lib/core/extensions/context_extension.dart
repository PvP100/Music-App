import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/core/constants/shared_preferences_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';
import '../../config/config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/utils/app_utils.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {bool rootNavigator = false,
      Map<String, dynamic>? arguments,
      TransitionType transitionType = TransitionType.ios}) {
    final pushArguments = <String, dynamic>{
      'transition_type': transitionType,
    };
    if (arguments != null) {
      pushArguments.addAll(arguments);
    }
    return Navigator.of(this, rootNavigator: rootNavigator).pushNamed(
      routeName,
      arguments: pushArguments,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?>(String routeName,
      {bool rootNavigator = false,
      Map<String, dynamic>? arguments,
      TransitionType transitionType = TransitionType.ios}) {
    final pushArguments = <String, dynamic>{
      'transition_type': transitionType,
    };
    if (arguments != null) {
      pushArguments.addAll(arguments);
    }
    return Navigator.of(this, rootNavigator: rootNavigator)
        .pushReplacementNamed(
      routeName,
      arguments: pushArguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      String routeName, bool Function(Route<dynamic>) predicate,
      {bool rootNavigator = false,
      Map<String, dynamic>? arguments,
      TransitionType transitionType = TransitionType.ios}) {
    final pushArguments = <String, dynamic>{
      'transition_type': transitionType,
    };
    if (arguments != null) {
      pushArguments.addAll(arguments);
    }
    return Navigator.of(this, rootNavigator: rootNavigator)
        .pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: pushArguments,
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

  handleError(Failure exception, bool isBackToLoginOrRegister) {
    final localizations = AppLocalizations.of(this)!;
    switch (exception) {
      case NetWorkConnection():
        return AppUtils.showToast(localizations.noInternetConnection);
      case BadRequestError():
        return AppUtils.showToast(localizations.badRequest);
      case DataNotFoundError():
        return AppUtils.showToast(localizations.dataNotFound);
      case ServerError() || InternalServerError():
        return AppUtils.showToast(localizations.serverError);
      case UnAuthorizedError():
        {
          if (isBackToLoginOrRegister) {
            HaMusicSharedPreference mPrefs =
                GetIt.I.get<HaMusicSharedPreference>();
            mPrefs.removeKey(SharedPreferencesConstants.appToken);
            mPrefs.removeKey(SharedPreferencesConstants.appRefreshToken);
            pushNamedAndRemoveUntil(
                RouteConstants.loginOrRegister, (p0) => false,
                rootNavigator: true);
          }
          return AppUtils.showToast(exception.message);
        }
      case AppError():
        return AppUtils.showToast(exception.message);
    }
  }

  AppLocalizations localizations() => AppLocalizations.of(this)!;

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  double get safeAreaBottomHeight => MediaQuery.viewPaddingOf(this).bottom;

  double get statusBarHeight => MediaQuery.viewPaddingOf(this).top;

  double get bottomBarHeight =>
      kBottomNavigationBarHeight + safeAreaBottomHeight;
}
