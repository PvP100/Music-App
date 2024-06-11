import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/image_constants.dart';
import '../../../../../../core/core.dart';
import '../../../../blocs/blocs.dart';
import '../../screens.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key, this.iconSize = 24});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, bool>(
      selector: (state) => state.playState?.showMiniPlayer ?? false,
      builder: (context, state) {
        return Container(
            height: context.bottomBarHeight +
                (state ? AppConstants.musicPlayHeight : 0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryBackgroundColor,
                  AppColors.primaryBackgroundColor.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.2, 1],
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
                      onTap: (index) => _onTabChanged(index, context),
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
            ));
      },
    );
  }

  _onTabChanged(int index, BuildContext context) {
    MainBloc bloc = context.read<MainBloc>();
    bloc.changScreen(TabNavigation.values[index]);
  }
}
