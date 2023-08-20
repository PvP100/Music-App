import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

extension StringExtension on String? {
  bool isPhoneNumber() {
    RegExp regex = RegExp(r'^\+?0[0-9]{9}$');

    return regex.hasMatch(this ?? "");
  }

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
      return const SizedBox();
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
}
