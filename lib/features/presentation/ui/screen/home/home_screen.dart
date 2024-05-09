import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';

import '../../../blocs/home/home_bloc.dart';
import '../base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeBloc, HomeState> {
  HomeScreen({super.arguments});

  @override
  Widget buildChild() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Center(
        child: state.imageUrl.loadImageUrl(),
      );
    });
  }
}
