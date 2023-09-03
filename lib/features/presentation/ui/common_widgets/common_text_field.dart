import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    this.controller,
    this.hintText = "",
    this.isPassword = false,
    this.backgroundColor = AppColors.color3E3E3E,
    this.hintTextColor = AppColors.color999999,
    this.margin,
  });

  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final EdgeInsets? margin;
  final Color backgroundColor;
  final Color hintTextColor;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool isShowPassword;

  @override
  void initState() {
    isShowPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: widget.margin,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 13),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          TextField(
            cursorColor: AppColors.primary,
            controller: widget.controller,
            obscureText: isShowPassword,
            style: AppTextStyles.hintText.copyWith(color: Colors.white),
            decoration: InputDecoration.collapsed(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.hintText
                    .copyWith(height: 17 / 14, color: widget.hintTextColor)),
          ).expanded(),
          if (widget.isPassword) ...{
            (isShowPassword
                    ? (widget.backgroundColor == Colors.white
                        ? ImageConstants.iconShowPasswordGray
                        : ImageConstants.iconShowPassword)
                    : (widget.backgroundColor == Colors.white
                        ? ImageConstants.iconHidePasswordGray
                        : ImageConstants.iconHidePassword))
                .loadImageAsset(height: 20, width: 20)
                .paddingSymmetric(horizontal: 10)
                .onCupertinoClick(() => setState(() {
                      isShowPassword = !isShowPassword;
                    }))
          }
        ],
      ),
    );
  }
}
