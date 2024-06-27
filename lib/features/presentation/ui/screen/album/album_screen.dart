import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/presentation/blocs/album/album_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/album/delegate/album_header_delegate.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

import '../../../blocs/blocs.dart';
import '../screens.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState
    extends BaseScreenState<AlbumScreen, AlbumBloc, AlbumState> {
  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  @override
  void onReveiveArguments(Map<String, dynamic> arguments) {
    if (arguments.containsKey(ArgumentKey.albumPlaylistId)) {
      bloc.getData(arguments[ArgumentKey.albumPlaylistId],
          (arguments[ArgumentKey.isAlbum] as bool?) ?? false);
    }
  }

  _play(bool isShuffle) {
    final songs = bloc.state.entity?.songs ?? [];
    if (songs.isNotEmpty) {
      int index = isShuffle ? Random().nextInt(songs.length) : 0;
      context.read<AppBloc>().playMusic(songs[index].data?.id ?? "");
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      color: AppColors.primaryBackgroundColor,
      child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: AlbumHeaderDelegate(
                appBarHeight: context.statusBarHeight + 56,
                name: state.entity?.name,
                image: state.entity?.thumbnail,
                onPlay: _play,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverList.builder(
                itemCount: state.entity?.songs?.length ?? 0,
                itemBuilder: (context, index) {
                  final model = state.entity?.songs?[index];
                  return SongItemWidget(
                    type: TrackType.song,
                    id: model?.data?.id,
                    name: model?.data?.name,
                    image: model?.data?.thumbnail,
                    artists: model?.data?.singers
                        ?.map((e) => e.data?.name ?? "")
                        .join(", "),
                  );
                },
              ),
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
      }),
    );
  }
}
