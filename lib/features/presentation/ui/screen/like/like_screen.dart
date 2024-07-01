import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

import '../../../blocs/blocs.dart';
import '../screens.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState
    extends BaseScreenState<LikeScreen, LikeBloc, LikeState> {
  @override
  bool get safeAreaBottom => false;

  @override
  void onAppStateListener(BuildContext context, AppState state) {
    if (state.isLiked == true) {
      bloc.getProfile();
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      color: AppColors.primaryBackgroundColor,
      child: BlocBuilder<LikeBloc, LikeState>(builder: (context, state) {
        return Column(
          children: [
            const HaMusicAppBar(title: "Bài hát yêu thích"),
            CustomScrollView(
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await bloc.getProfile();
                  },
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  sliver: SliverList.builder(
                    itemCount: state.songs?.models.length ?? 0,
                    itemBuilder: (context, index) {
                      final model = state.songs?.models[index];
                      return SongItemWidget(
                        songIds: state.songs?.models
                            .map((e) => e.data?.id ?? "")
                            .toList(),
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
            ).expanded(),
          ],
        );
      }),
    );
  }
}
