import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/presentation/blocs/track/track_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/play_widget.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState
    extends BaseScreenState<TrackScreen, TrackBloc, TrackState> {
  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BlocSelector<TrackBloc, TrackState,
                  ObjectListEntity<TrackModel>?>(
              selector: (state) => state.track,
              builder: (context, track) {
                return PageView.builder(
                  controller: _controller,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) =>
                      TrackImageWidget(model: track?.models[index]),
                  itemCount: track?.models.length ?? 0,
                );
              }),
        ),
        Positioned.fill(
            child: IgnorePointer(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x00000000),
              Color(0xFF000000),
            ],
          ))),
        )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BlocBuilder<TrackBloc, TrackState>(
              buildWhen: (previous, current) =>
                  previous.currentIndex != current.currentIndex,
              builder: (context, state) {
                TrackModel? model =
                    state.track?.models[state.currentIndex ?? 0];
                return PlayWidget(track: model);
              }),
        )
      ],
    );
  }

  _onPageChanged(int index) {
    bloc.changeTrack(index);
  }
}

class TrackImageWidget extends StatelessWidget {
  const TrackImageWidget({super.key, this.model});

  final TrackModel? model;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: (model?.album?.images?.firstOrNull?.url).loadImageUrl(),
          ),
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Transform.flip(
              flipY: true,
              child: (model?.album?.images?.firstOrNull?.url).loadImageUrl(),
            ),
          )
        ],
      ),
    );
  }
}
