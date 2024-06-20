import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/album/album_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/album/delegate/album_header_delegate.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/library/widgets/library_item.dart';

import '../screens.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState
    extends BaseScreenState<AlbumScreen, AlbumBloc, AlbumState> {
  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      color: AppColors.primaryBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: AlbumHeaderDelegate(
              appBarHeight: context.statusBarHeight + 56,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: context.bottomBarHeight,
            ),
            sliver: SliverList.builder(
              itemCount: 50,
              itemBuilder: (context, index) => SearchItemWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
