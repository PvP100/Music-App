import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/search/search_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/custom/search_widget.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

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
        Text(
          localizations.recentlySearched,
          textAlign: TextAlign.start,
          style: AppTextStyles.bold,
        ).paddingSymmetric(vertical: 10, horizontal: 13),
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
        ).paddingOnly(bottom: 10),
        ListView.builder(
                padding: EdgeInsets.fromLTRB(13, 0, 13,
                    context.bottomBarHeight + AppConstants.musicPlayHeight),
                itemCount: 10,
                itemBuilder: ((context, index) => const SearchItemWidget()))
            .expanded()
      ],
    );
  }

  @override
  bool get safeAreaBottom => false;
}

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          ClipRRect(
                  borderRadius: BorderRadius.all(7.radius),
                  child:
                      "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"
                          .loadImageUrl(width: 50, height: 50))
              .paddingOnly(right: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular,
              ),
              Text("Bài hát・24kGoldn",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular.copyWith(fontSize: 12))
            ],
          ).expanded(),
        ],
      ),
    );
  }
}
