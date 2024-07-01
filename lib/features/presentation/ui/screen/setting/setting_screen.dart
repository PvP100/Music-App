import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/setting/setting_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import '../../common_widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState
    extends BaseScreenState<SettingScreen, SettingBloc, SettingState> {
  @override
  void onStateListener(BuildContext context, SettingState state) {
    if (state.isLogout) {
      context.pushNamedAndRemoveUntil(
        RouteConstants.loginOrRegister,
        (p0) => false,
        rootNavigator: true,
      );
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HaMusicAppBar(
          title: context.localizations().settingStr,
        ),
        Text(
          context.localizations().accountStr,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColors.colorCACACA,
          ),
        ).paddingLTRB(30, 15, 0, 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppDimens.dimen20),
          decoration: BoxDecoration(
            color: AppColors.color3D3D3D,
            borderRadius: BorderRadius.all(8.radius),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                child: Row(
                  children: [
                    Text(
                      context.localizations().personalInformation,
                      style: AppTextStyles.medium.copyWith(fontSize: 16),
                    ).expanded(),
                    ImageConstants.iconRightArrow.loadImageAsset(
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ).onCupertinoClick(_goToInformation),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 15),
              //   height: 35,
              //   child: Row(
              //     children: [
              //       Text(
              //         context.localizations().changePassword,
              //         style: AppTextStyles.medium.copyWith(fontSize: 16),
              //       ).expanded(),
              //       ImageConstants.iconRightArrow.loadImageAsset(
              //         height: 24,
              //         width: 24,
              //       ),
              //     ],
              //   ),
              // ).onCupertinoClick(_changePassword),
            ],
          ),
        ),
        // Text(
        //   context.localizations().otherStr,
        //   style: AppTextStyles.medium.copyWith(
        //     fontSize: 14,
        //     color: AppColors.colorCACACA,
        //   ),
        // ).paddingLTRB(30, 25, 0, 10),
        // Container(
        //   height: 35,
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   margin: const EdgeInsets.symmetric(horizontal: AppDimens.dimen20),
        //   decoration: BoxDecoration(
        //     color: AppColors.color3D3D3D,
        //     borderRadius: BorderRadius.all(8.radius),
        //   ),
        //   child: Row(
        //     children: [
        //       Text(
        //         context.localizations().appInformation,
        //         style: AppTextStyles.medium.copyWith(fontSize: 16),
        //       ).expanded(),
        //       ImageConstants.iconRightArrow.loadImageAsset(
        //         height: 24,
        //         width: 24,
        //       ),
        //     ],
        //   ),
        // ).onCupertinoClick(_goToAppInformation),
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimen20,
            vertical: AppDimens.dimen40,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.color3D3D3D,
            borderRadius: BorderRadius.all(8.radius),
          ),
          child: Text(
            context.localizations().logout,
            style: AppTextStyles.medium.copyWith(fontSize: 14),
          ).onCupertinoClick(_logout),
        )
      ],
    );
  }

  _goToAppInformation() {}

  _goToInformation() {
    context.pushNamed(RouteConstants.personal);
  }

  _changePassword() {}

  _logout() {
    bloc.logout();
  }
}
