import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/presentation/blocs/profile/profile_bloc.dart';

import '../../../../../../core/core.dart';

class TopProfile extends StatelessWidget {
  const TopProfile({super.key, this.profile});

  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          color: AppColors.color4A4A4A,
          borderRadius: BorderRadius.all(10.radius)),
      child: BlocSelector<ProfileBloc, ProfileState, Profile?>(
          selector: (state) => state.profile,
          builder: (context, profile) {
            return Column(children: [
              Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: profile?.avatar.filePathUrl().loadImageUrl(),
              ).align(heightFactor: 0.5, alignment: Alignment.bottomCenter),
              Text(
                "${profile?.lastName ?? ""} ${profile?.firstName ?? ""}",
                style: AppTextStyles.bold.copyWith(fontSize: 20),
              ).paddingOnly(top: 17, bottom: 22),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "${profile?.artist?.length ?? 0}",
                        style: AppTextStyles.bold.copyWith(fontSize: 18),
                      ),
                      Text(
                        "Đang theo dõi",
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: AppColors.colorCACACA,
                        ),
                      )
                    ],
                  ).expanded(),
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${profile?.totalSong ?? 0}",
                        style: AppTextStyles.bold.copyWith(fontSize: 18),
                      ),
                      Text(
                        "Bài hát yêu thích",
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: AppColors.colorCACACA,
                        ),
                      )
                    ],
                  ).expanded(),
                ],
              )
            ]);
          }),
    );
  }
}
