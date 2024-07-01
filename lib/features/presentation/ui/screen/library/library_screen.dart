import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/enum/search_type.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/artist_item_widget.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/dialogs/add_play_list_dialog.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/screens.dart';

import 'widgets/like_playlist_item.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState
    extends BaseScreenState<LibraryScreen, LibraryBloc, LibraryState>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _controller = TextEditingController();

  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: 400.milliseconds,
    );
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void onAppStateListener(BuildContext context, AppState state) {
    if (state.isUpdateProfile) {
      bloc.getProfile();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state) {
      return CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await bloc.getProfile();
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppCircleAvatar(url: state.profile?.avatar),
                    const Spacer(),
                    // ImageConstants.iconAdd
                    //     .loadImageAsset(height: 24, width: 24)
                    //     .onCupertinoClick(() {
                    //   showModalBottomSheet(
                    //     useRootNavigator: true,
                    //     isScrollControlled: false,
                    //     context: context,
                    //     builder: (dialogContext) => AddSongDialog(
                    //       onCreatePlaylist: _onCreatePlaylist,
                    //       onSearch: () {
                    //         context
                    //             .read<MainBloc>()
                    //             .changScreen(TabNavigation.search);
                    //       },
                    //     ),
                    //   );
                    // })
                  ],
                ).paddingSymmetric(horizontal: 15, vertical: 5),
                CommonTabBar(
                  listTitle: [
                    context.localizations().artist,
                    context.localizations().album,
                    context.localizations().playlist,
                  ],
                  tabController: _tabController,
                  onTabChanged: _tabChanged,
                ).paddingOnly(left: 15, top: 8)
              ],
            ),
          ),
          // SliverAppBar(
          //   primary: false,
          //   pinned: true,
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   toolbarHeight: 50,
          //   backgroundColor: Colors.transparent,
          //   flexibleSpace: Container(
          //     color: AppColors.primaryBackgroundColor,
          //     child: Center(
          //       child: Row(
          //         children: [
          //           SearchWidget(
          //             onSearch: (value) {},
          //             controller: _controller,
          //           ).expanded(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: context.bottomBarHeight + 15,
              left: 15,
              right: 15,
            ),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => SizedBox(
                  height: index == 0 && state.type == SearchType.playlist
                      ? 20
                      : 10),
              itemCount: (state.entities?.length ?? 0) +
                  (state.type == SearchType.playlist ? 1 : 0),
              itemBuilder: (context, index) {
                return index == 0 && state.type == SearchType.playlist
                    ? LikePlaylistItem(
                        total: state.profile?.totalSong ?? 0,
                      )
                    : (state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .type ==
                            TrackType.artist
                        ? ArtistItemWidget(entity: state.entities?[index])
                        : SongItemWidget(
                            type: state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .type,
                            id: state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .id,
                            image: state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .image,
                            name: state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .name,
                            artists: state
                                .entities?[state.type == SearchType.playlist
                                    ? index - 1
                                    : index]
                                .artist,
                          ));
              },
            ),
          )
        ],
      );
    });
  }

  @override
  bool get safeAreaBottom => false;

  _tabChanged(int index) {
    bloc.changePage(index);
  }

  _onCreatePlaylist() {
    showModalBottomSheet(
      transitionAnimationController: _animationController,
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: AppDimens.dimen15.radius),
      ),
      builder: (dialogContext) => const AddPlaylistDialog(),
    );
  }
}
