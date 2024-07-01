import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/app/app_bloc.dart';

import '../../../../../domain/entities/home_menu_entity.dart';

class HomeNewAlbumCategory extends StatelessWidget {
  const HomeNewAlbumCategory({super.key, this.entity});

  final HomeMenuEntity? entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entity?.title ?? "",
          style: AppTextStyles.bold.copyWith(fontSize: 20),
        ).paddingOnly(left: 15, bottom: 10),
        SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final model = entity?.data?[index];
                return Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      foregroundDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.white.withOpacity(0)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              model?.thumbnail ?? ""),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 13,
                      right: 13,
                      bottom: 13,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model?.name ?? "",
                                maxLines: 1,
                                style:
                                    AppTextStyles.bold.copyWith(fontSize: 18),
                              ),
                              Text(
                                model?.artists ?? "",
                                maxLines: 1,
                                style: AppTextStyles.medium
                                    .copyWith(color: AppColors.colorCACACA),
                              )
                            ],
                          ).expanded(),
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: ImageConstants.iconPlayBlack
                                .loadImageAsset(width: 20, height: 20),
                          ).onCupertinoClick(() => _navigateToTrack(
                                context,
                                model?.id ?? "",
                              ))
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: ((context, index) => const SizedBox(width: 15)),
              itemCount: entity?.data?.length ?? 0),
        )
      ],
    );
  }

  _navigateToTrack(BuildContext context, String songId) {
    context.read<AppBloc>().playMusic(songId);
  }

  _navigateToDetail(BuildContext context) {
    context.pushNamed(RouteConstants.album);
  }
}
