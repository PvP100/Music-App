import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
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
                  const CircleAvatar(
                    radius: 20,
                    foregroundImage: CachedNetworkImageProvider(
                        "https://images.unsplash.com/photo-1692221307059-8819db116d92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"),
                  ),
                  const Spacer(),
                  ImageConstants.iconAdd
                      .loadImageAsset(height: 24, width: 24)
                      .onCupertinoClick(() {
                    showModalBottomSheet(
                      isScrollControlled: false,
                      context: context,
                      builder: (dialogContext) => AddSongDialog(
                        onCreatePlaylist: () {},
                        onSearch: () {
                          context
                              .read<MainBloc>()
                              .add(OnTabClickEvent(TabNavigation.search));
                        },
                      ),
                    );
                  })
                ],
              ).paddingSymmetric(horizontal: 15, vertical: 5),
              TabBar(
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                splashFactory: NoSplash.splashFactory,
                indicator: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.medium.copyWith(fontSize: 14),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.colorCACACA,
                isScrollable: true,
                tabs: [
                  Text(localizations.all)
                      .paddingSymmetric(vertical: 5.5, horizontal: 16),
                  Text(localizations.playlist)
                      .paddingSymmetric(vertical: 5.5, horizontal: 16),
                  Text(localizations.album)
                      .paddingSymmetric(vertical: 5.5, horizontal: 16),
                  Text(localizations.artist)
                      .paddingSymmetric(vertical: 5.5, horizontal: 16),
                ],
                controller: _tabController,
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
                  const SearchWidget().expanded(),
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
