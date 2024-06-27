import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_app/config/env_config.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/exception/failure.dart';

extension StringExtension on String? {
  bool isPhoneNumber() {
    RegExp regex = RegExp(r'^\+?0[0-9]{9}$');

    return regex.hasMatch(this ?? "");
  }

  Failure toFailure() => Failure.error(this ?? AppConstants.emptyString);

  bool isEmail() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this ?? "");
    return emailValid;
  }

  Widget loadImageUrl({
    Widget? placeHolder,
    Widget? errorWidget,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    int? memCacheWidth,
    int? memCacheHeight,
  }) {
    if (this != null && this?.isNotEmpty == true) {
      return CachedNetworkImage(
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        height: height,
        width: width,
        fit: fit,
        imageUrl: this!,
        errorWidget: (context, url, error) => errorWidget ?? const SizedBox(),
        placeholder: (context, url) =>
            Center(child: placeHolder ?? const CircularProgressIndicator()),
      );
    } else {
      return "music_placeholder".loadImageAsset();
    }
  }

  Widget loadImageAsset(
      {String withExtension = "png",
      BoxFit fit = BoxFit.cover,
      double? width,
      double? height,
      int? memCacheWidth,
      int? memCacheHeight}) {
    return Image.asset(
      "assets/images/$this.$withExtension",
      fit: fit,
      cacheHeight: memCacheHeight,
      cacheWidth: memCacheWidth,
      height: height,
      width: width,
    );
  }

  String filePathUrl() => "${EnvConfig.baseUrl}assets/$this";

  String convertDateTimeTo() {
    if (this != null) {
      DateTime tempDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(this!);
      return DateFormat("dd/MM/yyyy").format(tempDate);
    } else {
      return "Không";
    }
  }

  String convertDateTime() {
    if (this != null) {
      DateTime tempDate = DateFormat("dd/MM/yyyy").parse(this!);
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(tempDate);
    } else {
      return "Không";
    }
  }
}
