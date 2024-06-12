import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/tab_navigator.dart';
import 'package:music_app/features/presentation/ui/custom/keep_alive_screen.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/track/track_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen, MainBloc, MainState>
    with TickerProviderStateMixin {
  final pages = [
    const KeepAliveScreen(
        child: TabNavigator(initialRoute: RouteConstants.home)),
    const KeepAliveScreen(
        child: TabNavigator(initialRoute: RouteConstants.category)),
    const KeepAliveScreen(
        child: TabNavigator(initialRoute: RouteConstants.library)),
  ];

  final PageController _pageController = PageController();

  final PanelController _panelController = PanelController();

  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    pages.clear();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onAppStateListener(BuildContext context, AppState state) {
    if (state.playState?.isPlay == true) {
      bloc.getTrack(bloc.ids.join(","));
    }
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
        BlocSelector<AppBloc, AppState, bool>(
          selector: (state) => state.playState?.showMiniPlayer ?? false,
          builder: (context, v) {
            return SlidingUpPanel(
              onPanelSlide: (position) {
                _animationController.value = position;
              },
              controller: _panelController,
              isDraggable: v,
              minHeight: context.bottomBarHeight +
                  (v ? AppConstants.musicPlayHeight : 0),
              boxShadow: const [],
              maxHeight: context.height,
              color: Colors.transparent,
              panel: TrackScreen(
                onClose: _panelController.close,
                animationController: _animationController,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void onStateListener(BuildContext context, MainState state) {
    if (_pageController.page != state.currentScreen.screenIndex) {
      _pageController.jumpToPage(state.currentScreen.screenIndex);
    }
  }

  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  @override
  bool get resizeToAvoidBottomInset => false;
}

enum TabNavigation {
  home(0),
  search(1),
  library(2);

  final int screenIndex;

  const TabNavigation(this.screenIndex);
}
