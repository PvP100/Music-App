import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/app/app_bloc.dart';

class HomeNewAlbumCategory extends StatelessWidget {
  const HomeNewAlbumCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Album mới nổi bật",
          style: AppTextStyles.bold.copyWith(fontSize: 20),
        ).paddingOnly(left: 15, bottom: 10),
        SizedBox(
          height: 250,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
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
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  "https://images.unsplash.com/photo-1519834785169-98be25ec3f84?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80"))),
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
                                "Stray Nights",
                                maxLines: 1,
                                style:
                                    AppTextStyles.bold.copyWith(fontSize: 18),
                              ),
                              Text(
                                "Tom Frane",
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
                          ).onCupertinoClick(() => _navigateToTrack(context))
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: ((context, index) => const SizedBox(width: 15)),
              itemCount: 10),
        )
      ],
    );
  }

  _navigateToTrack(BuildContext context) {
    context.read<AppBloc>().playMusic();
  }
}
