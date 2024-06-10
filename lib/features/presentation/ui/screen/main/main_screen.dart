import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
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

  final double iconSize = 24;

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
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
        SlidingUpPanel(
          onPanelSlide: (position) {
            _animationController.value = position;
          },
          controller: _panelController,
          minHeight: context.bottomBarHeight + AppConstants.musicPlayHeight / 2,
          maxHeight: context.height,
          color: Colors.transparent,
          collapsed: Stack(
            children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryBackgroundColor,
                        AppColors.primaryBackgroundColor.withOpacity(0.85),
                        AppColors.primaryBackgroundColor.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.5, 1],
                    ),
                  ),
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BlocSelector<MainBloc, MainState, TabNavigation>(
                        selector: (state) => state.currentScreen,
                        builder: (context, value) {
                          return BottomNavigationBar(
                            onTap: (index) =>
                                bloc.changScreen(TabNavigation.values[index]),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            currentIndex: value.screenIndex,
                            type: BottomNavigationBarType.fixed,
                            selectedFontSize: 0,
                            unselectedFontSize: 0,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            items: [
                              BottomNavigationBarItem(
                                label: AppConstants.emptyString,
                                icon: ImageConstants.iconHomeUnselected
                                    .loadImageAsset(height: iconSize),
                                activeIcon: ImageConstants.iconHomeSelected
                                    .loadImageAsset(height: iconSize),
                              ),
                              BottomNavigationBarItem(
                                label: AppConstants.emptyString,
                                icon: ImageConstants.iconSearchUnselected
                                    .loadImageAsset(
                                        height: iconSize, width: iconSize),
                                activeIcon: ImageConstants.iconSearchSelected
                                    .loadImageAsset(
                                        height: iconSize, width: iconSize),
                              ),
                              BottomNavigationBarItem(
                                label: AppConstants.emptyString,
                                icon: ImageConstants.iconLibraryUnselected
                                    .loadImageAsset(
                                        height: iconSize, width: iconSize),
                                activeIcon: ImageConstants.iconLibrarySelected
                                    .loadImageAsset(
                                        height: iconSize, width: iconSize),
                              ),
                            ],
                          );
                        }),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 46,
                      width: 46,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s"
                              .loadImageUrl(),
                    ),
                    const Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ],
          ),
          panel: AnimatedBuilder(
            animation: _animationController,
            child: TrackScreen(onClose: _panelController.close),
            builder: (context, child) => Opacity(
              opacity: _animationController.value,
              child: child,
            ),
          ),
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
