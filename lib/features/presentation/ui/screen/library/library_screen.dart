import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/custom/search_widget.dart';
import 'package:music_app/features/presentation/ui/dialogs/add_song_dialog.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/screens.dart';

import 'widgets/library_item.dart';

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

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AppCircleAvatar(),
                  const Spacer(),
                  ImageConstants.iconAdd
                      .loadImageAsset(height: 24, width: 24)
                      .onCupertinoClick(() {
                    showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: false,
                      context: context,
                      builder: (dialogContext) => AddSongDialog(
                        onCreatePlaylist: () {},
                        onSearch: () {
                          context
                              .read<MainBloc>()
                              .changScreen(TabNavigation.search);
                        },
                      ),
                    );
                  })
                ],
              ).paddingSymmetric(horizontal: 15, vertical: 5),
              CommonTabBar(
                listTitle: [
                  context.localizations().all,
                  context.localizations().playlist,
                  context.localizations().album,
                  context.localizations().artist
                ],
                tabController: _tabController,
              ).paddingOnly(left: 15, top: 8)
            ],
          ),
        ),
        SliverAppBar(
          primary: false,
          pinned: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            color: AppColors.primaryBackgroundColor,
            child: Center(
              child: Row(
                children: [
                  SearchWidget(
                    controller: _controller,
                  ).expanded(),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            top: 3,
            bottom: context.bottomBarHeight,
            left: 15,
            right: 15,
          ),
          sliver: SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: 10,
            itemBuilder: (context, index) => const LibraryItem(),
          ),
        )
      ],
    );
  }

  @override
  bool get safeAreaBottom => false;
}
