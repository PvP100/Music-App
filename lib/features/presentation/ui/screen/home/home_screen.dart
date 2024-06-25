import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';
import '../../../../domain/entities/home_menu_entity.dart';
import '../base_screen_state.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState
    extends BaseScreenState<HomeScreen, HomeBloc, HomeState> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {
        if (state.currentScreen == TabNavigation.home &&
            _controller.offset != 0) {
          _controller.animateTo(0,
              duration: 200.milliseconds, curve: Curves.decelerate);
        }
      },
      listenWhen: (previous, current) =>
          previous.currentScreen == current.currentScreen,
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverToBoxAdapter(
            child: Row(children: [
              Text(
                _welcomeStr,
                style: AppTextStyles.bold.copyWith(fontSize: 28),
              ).expanded(),
              const AppCircleAvatar()
            ]).paddingSymmetric(horizontal: 15, vertical: 20),
          ),
          BlocSelector<HomeBloc, HomeState, List<HomeMenuEntity>?>(
              selector: (state) => state.entities,
              builder: (context, v) {
                return SliverList.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: v?.length ?? 0,
                  itemBuilder: (context, index) {
                    final model = v?[index];
                    return (model?.isSong ?? false)
                        ? HomeNewAlbumCategory(
                            entity: model,
                            key: PageStorageKey<String>("$index"),
                          )
                        : HomeCategoryItem(
                            entity: model,
                            key: PageStorageKey<String>("$index"),
                          );
                  },
                );
              }),
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.playState?.isPlay ?? false,
            builder: (context, v) => SliverPadding(
                padding: EdgeInsets.only(
                    bottom: context.bottomBarHeight +
                        (v ? AppConstants.musicPlayHeight : 0))),
          )
        ],
      ),
    );
  }

  String get _welcomeStr {
    final currentHour = DateTime.now().hour;
    if (currentHour < 12) {
      return localizations.goodMorning;
    }
    if (currentHour < 17) {
      return localizations.goodAfternoon;
    }
    return localizations.goodEvening;
  }

  @override
  bool get safeAreaBottom => false;
}
