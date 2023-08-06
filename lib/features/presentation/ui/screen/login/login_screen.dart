import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/hamusic_app_bar.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState
    extends BaseScreenState<LoginScreen, LoginBloc, LoginState> {
  @override
  Widget get buildContent {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      HaMusicAppBar(
        title: AppLocalizations.of(context)!.login,
      ),
      ImageConstants.iconLogo
          .loadImageAsset(height: 85, fit: BoxFit.fitHeight)
          .paddingOnly(
            top: 40,
            bottom: 60,
          ),
    ]);
  }

  @override
  Color get backgroundColor => ColorConstants.primaryBackgroundColor;

  @override
  bool get safeAreaBottom => false;
}
