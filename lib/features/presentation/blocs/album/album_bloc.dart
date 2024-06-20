import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'album_state.dart';

class AlbumBloc extends BaseBloc<AlbumState> {
  AlbumBloc() : super(const AlbumState());
}
