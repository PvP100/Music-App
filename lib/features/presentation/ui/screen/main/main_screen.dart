import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/custom/keep_alive_screen.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState
    extends BaseScreenState<MainScreen, MainBloc, MainState> {
  final pages = [
    const KeepAliveScreen(child: HomeScreen()),
    const KeepAliveScreen(child: SearchScreen()),
    const KeepAliveScreen(child: LibraryScreen()),
  ];

  final PageController _pageController = PageController();

  final double iconSize = 24;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }

  @override
  Widget? get footer {
    return Container(
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
        height: context.bottomBarHeight + 70,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BlocSelector<MainBloc, MainState, TabNavigation>(
              selector: (state) => state.currentScreen,
              builder: (context, value) {
                return BottomNavigationBar(
                  onTap: (index) => bloc.add(
                    OnTabClickEvent(TabNavigation.values[index]),
                  ),
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
                          .loadImageAsset(height: iconSize, width: iconSize),
                      activeIcon: ImageConstants.iconSearchSelected
                          .loadImageAsset(height: iconSize, width: iconSize),
                    ),
                    BottomNavigationBarItem(
                      label: AppConstants.emptyString,
                      icon: ImageConstants.iconLibraryUnselected
                          .loadImageAsset(height: iconSize, width: iconSize),
                      activeIcon: ImageConstants.iconLibrarySelected
                          .loadImageAsset(height: iconSize, width: iconSize),
                    ),
                  ],
                );
              }),
        ));
  }

  @override
  void onStateListener(BuildContext context, MainState state) {
    if (_pageController.page != state.currentScreen.screenIndex) {
      _pageController.jumpToPage(state.currentScreen.screenIndex);
    }
  }

  @override
  bool get safeAreaBottom => false;
}

enum TabNavigation {
  home(0),
  search(1),
  library(2);

  final int screenIndex;

  const TabNavigation(this.screenIndex);
}
