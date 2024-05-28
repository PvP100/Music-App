import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/exception/failure.dart';
part 'base_state.dart';

abstract class BaseBloc<S extends BaseState> extends Cubit<S> {
  late AppLocalizations localizations;

  BaseBloc(super.initialState) {
    init();
  }

  void init() {}

  @protected
  void emitLoading() {
    Future.delayed(0.milliseconds)
        .then((value) => emit(state.copyWith(isLoading: true)));
  }

  @protected
  void emitError(Failure failure) {
    emit(state.copyWith(error: failure));
  }
}
