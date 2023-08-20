import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/core/extensions/widget_extension.dart';
import '../../../blocs/change_password/change_password_bloc.dart';
import '../../common_widgets/widgets.dart';
import '../base_screen_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends BaseScreenState<ChangePasswordScreen,
    ChangePasswordBloc, ChangePasswordState> {
  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        HaMusicAppBar(
          title: localizations.changePassword,
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                localizations.currentPassword,
                style: TextStyleConstants.medium,
              ),
              CommonTextField(
                isPassword: true,
                backgroundColor: Colors.white,
                hintText: localizations.yourCurrentPassword,
                hintTextColor: ColorConstants.colorACAAAF,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
              ),
              Text(
                localizations.newPassword,
                style: TextStyleConstants.medium,
              ),
              CommonTextField(
                isPassword: true,
                backgroundColor: Colors.white,
                hintText: localizations.enterNewPassword,
                hintTextColor: ColorConstants.colorACAAAF,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
              ),
              Text(
                localizations.reEnterNewPassword,
                style: TextStyleConstants.medium,
              ),
              CommonTextField(
                isPassword: true,
                backgroundColor: Colors.white,
                hintText: localizations.reEnterNewPassword,
                hintTextColor: ColorConstants.colorACAAAF,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
              ),
              Text(
                localizations.noteChangePasword,
                style: TextStyleConstants.regular.copyWith(
                  color: ColorConstants.colorACAAAF,
                  fontSize: 14,
                ),
              ),
              CommonButton(
                title: localizations.confirm,
                onClick: () {},
                margin: const EdgeInsets.only(top: 50),
              )
            ],
          ),
        ).expanded()
      ],
    );
  }
}
