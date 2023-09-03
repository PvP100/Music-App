import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';
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
              const CircleAvatar(
                radius: 20,
                foregroundImage: CachedNetworkImageProvider(
                    "https://images.unsplash.com/photo-1692221307059-8819db116d92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"),
              )
            ]).paddingSymmetric(horizontal: 15, vertical: 20),
          ),
          SliverList.separated(
            separatorBuilder: (context, index) =>
                SizedBox(height: index == 0 ? 15 : 8),
            itemCount: 10,
            itemBuilder: (context, index) {
              return index == 0
                  ? const HomeNewAlbumCategory()
                  : const HomeCategoryItem();
            },
          ),
          SliverPadding(
              padding: EdgeInsets.only(bottom: context.bottomBarHeight + 10))
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
