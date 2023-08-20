import 'package:flutter/material.dart';
import 'package:music_app/core/extensions/widget_extension.dart';
import 'package:music_app/features/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseScreenState<ForgotPasswordScreen,
    ForgotPasswordBloc, ForgotPasswordState> {
  @override
  Widget buildContent(BuildContext context) {
    return Column(children: [
      HaMusicAppBar(title: localizations.forgotPassword),
      SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 32),
        child: Column(children: [
          CommonTextField(
            hintText: localizations.emailOrPhone,
          ),
          CommonButton(
            title: localizations.continueTitle,
            margin: const EdgeInsets.only(top: 23),
            onClick: () {},
          )
        ]),
      ).expanded()
    ]);
  }
}
