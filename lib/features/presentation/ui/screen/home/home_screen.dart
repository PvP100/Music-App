import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';

import '../../../blocs/home/home_bloc.dart';
import '../base_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState
    extends BaseScreenState<HomeScreen, HomeBloc, HomeState> {
  @override
  Widget get buildContent {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Center(
        child: state.imageUrl.loadImageUrl(),
      );
    });
  }
}
