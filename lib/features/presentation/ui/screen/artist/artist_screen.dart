import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/home_menu_entity.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/screens.dart';

import '../home/widgets/widgets.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState
    extends BaseScreenState<ArtistScreen, ArtistBloc, ArtistState> {
  @override
  void onReveiveArguments(Map<String, dynamic> arguments) {
    if (arguments.containsKey(ArgumentKey.artistId)) {
      String? id = arguments[ArgumentKey.artistId];
      if (id != null) {
        bloc.getArtist(id);
      }
    }
  }

  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(builder: (context, state) {
      final model = state.model;
      final isLiked = state.isLiked;
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 375 / 320,
                  child: Stack(children: [
                    Positioned.fill(
                        child: (model?.thumbnail.filePathUrl()).loadImageUrl(
                      errorWidget: "music_placeholder".loadImageAsset(),
                      placeHolder: "music_placeholder".loadImageAsset(),
                    )),
                    Positioned.fill(
                        child: Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 12),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColors.primaryBackgroundColor,
                          Color(0x00000000),
                        ],
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            context.localizations().artist,
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 14,
                              color: AppColors.colorCACACA,
                            ),
                          ),
                          Text(
                            model?.name ?? "",
                            style: AppTextStyles.bold.copyWith(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    )),
                    Positioned(
                      top: context.statusBarHeight + 20,
                      left: 20,
                      child: ImageConstants.iconBack
                          .loadImageAsset(
                            height: 32,
                            width: 32,
                          )
                          .onCupertinoClick(context.pop),
                    )
                  ]),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                        top: 12,
                      ),
                      height: 40,
                      alignment: Alignment.center,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: Text(
                        "Phát",
                        style: AppTextStyles.medium.copyWith(fontSize: 16),
                      ),
                    ).onCupertinoClick(() {
                      final id = model?.songs?.firstOrNull?.data?.id;
                      if (id != null) {
                        context.read<AppBloc>().playMusic(
                            id,
                            model?.songs
                                ?.map((e) => e.data?.id ?? "")
                                .toList());
                      }
                    }),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: 40,
                      alignment: Alignment.center,
                      width: isLiked ? 140 : 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                        color: isLiked ? AppColors.primary : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isLiked ? "Đang theo dõi" : "Theo dõi",
                        style: AppTextStyles.medium.copyWith(fontSize: 16),
                      ),
                    ).onCupertinoClick(bloc.favorite)
                  ],
                ),
                Text(
                  "Phổ biến",
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 16,
                  ),
                ).paddingOnly(left: 15, top: 25, bottom: 18)
              ],
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              final m = model?.songs?[index].data;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}",
                    style: AppTextStyles.medium.copyWith(fontSize: 14),
                  ).paddingOnly(top: 15, left: 15, right: 15),
                  SongItemWidget(
                    songIds:
                        model?.songs?.map((e) => e.data?.id ?? "").toList(),
                    id: m?.id,
                    image: m?.thumbnail,
                    name: m?.name,
                    type: TrackType.song,
                    artists: m?.singers?.map((e) => e.data?.name).join(", "),
                  ).expanded(),
                ],
              );
            },
            itemCount: model?.songs?.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: HomeCategoryItem(
              entity: HomeMenuEntity(
                title: "Tuyển tập Playlist",
                data: model?.playlist
                    ?.map(
                      (e) => ChildHomeMenuEntity(
                        id: e.data?.id,
                        isPlaylist: true,
                        thumbnail: e.data?.thumbnail.filePathUrl(),
                        name: e.data?.name,
                        artists: e.data?.singers
                            ?.map((e) => e.data?.name)
                            .join(", "),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Thông tin",
                  style: AppTextStyles.bold,
                ),
                const SizedBox(height: 15),
                Text(
                  "Giới tính: ${model?.gender == "0" ? "Nam" : "Nữ"}",
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColors.colorABABAB,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sinh nhật: ${model?.birthday.convertDateTimeTo()}",
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColors.colorABABAB,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Quốc gia: ${model?.nation ?? ""}",
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColors.colorABABAB,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "TIỂU SỬ\n${model?.bio ?? ""}",
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColors.colorABABAB,
                  ),
                ),
              ],
            ).paddingOnly(left: 15, top: 20, right: 15, bottom: 20),
          ),
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.playState?.isPlay ?? false,
            builder: (context, v) => SliverPadding(
                padding: EdgeInsets.only(
                    bottom: context.bottomBarHeight +
                        (v ? AppConstants.musicPlayHeight : 0))),
          )
        ],
      );
    });
  }
}
