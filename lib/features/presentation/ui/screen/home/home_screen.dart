import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen.dart';

import '../../../blocs/home/home_bloc.dart';

class HomeScreen extends BaseScreen<HomeBloc, HomeState> {
  @override
  Widget buildChild() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Center(
        child: state.imageUrl.loadImageUrl(),
      );
    });
  }
}
