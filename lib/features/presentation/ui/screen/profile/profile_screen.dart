import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/profile/profile_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/library/widgets/library_item.dart';

import 'widgets/top_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends BaseScreenState<ProfileScreen, ProfileBloc, ProfileState> {
  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        HaMusicAppBar(
          onRightClick: () {},
          rightIcon: ImageConstants.iconSetting.loadImageAsset(
            height: 30,
            width: 30,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopProfile(),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.color4A4A4A,
                  borderRadius: BorderRadius.all(10.radius),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          localizations.recentlyPlayedSongs,
                          style: AppTextStyles.bold,
                        ).expanded(),
                        Text(
                          localizations.all,
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 12,
                            color: AppColors.colorCACACA,
                          ),
                        )
                      ],
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.only(top: 12, bottom: 3),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const LibraryItem(),
                      itemCount: 4,
                    )
                  ],
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 15),
        ).expanded()
      ],
    );
  }
}
