import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/enum/search_type.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/presentation/blocs/app/app_bloc.dart';
import 'package:music_app/features/presentation/blocs/search/search_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/custom/search_widget.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

import '../../common_widgets/artist_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState
    extends BaseScreenState<SearchScreen, SearchBloc, SearchState>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _controller = AnimationController(vsync: this, duration: 250.milliseconds);
    _controller.forward();
    _focusNode.requestFocus();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        bloc.search("", SearchType.values[_tabController.index]);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SearchWidget(
              onSearch: (value) {
                bloc.search(
                    value.trim(), SearchType.values[_tabController.index]);
              },
              focusNode: _focusNode,
              controller: _searchController,
            ).expanded(),
            SizeTransition(
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _controller,
              child: Text(
                localizations.cancel,
                style: AppTextStyles.medium.copyWith(color: AppColors.primary),
              ).paddingOnly(right: 13).onCupertinoClick(() {
                context.pop();
                _controller.reverse();
              }),
            )
          ],
        ),
        // Text(
        //   localizations.recentlySearched,
        //   textAlign: TextAlign.start,
        //   style: AppTextStyles.bold,
        // ).paddingSymmetric(vertical: 10, horizontal: 13),
        CommonTabBar(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          tabController: _tabController,
          listTitle: [
            localizations.topResult,
            localizations.artist,
            localizations.album,
            localizations.song,
            localizations.playlist
          ],
          onTabChanged: _tabChanged,
        ).paddingOnly(bottom: 10, top: 10),
        BlocSelector<SearchBloc, SearchState, ObjectListEntity<SearchEntity>?>(
            selector: (state) => state.data,
            builder: (context, v) {
              return ListView.builder(
                  padding: EdgeInsets.fromLTRB(13, 0, 13,
                      context.bottomBarHeight + AppConstants.musicPlayHeight),
                  itemCount: v?.models.length ?? 0,
                  itemBuilder: ((context, index) {
                    final model = v?.models[index];
                    return switch (model?.type) {
                      TrackType.artist => ArtistItemWidget(entity: model),
                      _ => SongItemWidget(
                          type: model?.type,
                          id: model?.id,
                          image: model?.image,
                          name: model?.name,
                          artists: model?.artist,
                        ).paddingSymmetric(horizontal: 15, vertical: 2.5)
                    };
                  })).expanded();
            })
      ],
    );
  }

  @override
  bool get safeAreaBottom => false;

  _tabChanged(int index) {
    bloc.search(_searchController.text.trim(), SearchType.values[index]);
  }
}

class SongItemWidget extends StatelessWidget {
  const SongItemWidget({
    super.key,
    this.image,
    this.name,
    this.id,
    this.artists,
    this.type,
  });

  final String? image;

  final String? name;

  final String? artists;

  final String? id;

  final TrackType? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          ClipRRect(
                  borderRadius: BorderRadius.all(7.radius),
                  child: image.filePathUrl().loadImageUrl(
                      width: 50,
                      height: 50,
                      errorWidget: "music_placeholder".loadImageAsset(),
                      placeHolder: "music_placeholder".loadImageAsset()))
              .paddingOnly(right: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular,
              ),
              Text("${_typeName()} - $artists",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular.copyWith(fontSize: 12))
            ],
          ).expanded(),
        ],
      ).onCupertinoClick(() => _click(context)),
    );
  }

  _click(BuildContext context) {
    switch (type) {
      case TrackType.album || TrackType.playlist:
        {
          context.pushNamed(RouteConstants.album, arguments: {
            ArgumentKey.albumPlaylistId: id,
            ArgumentKey.isAlbum: type == TrackType.album,
          });
        }
      case TrackType.song:
        {
          if (id != null) {
            context.read<AppBloc>().playMusic(id!);
          }
        }
      default:
        {}
    }
  }

  String _typeName() => switch (type) {
        TrackType.album => "Album",
        TrackType.song => "Bài hát",
        TrackType.playlist => "Playlist",
        _ => ""
      };
}
