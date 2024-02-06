import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:music_app/features/data/exception/failure.dart';
part 'base_state.dart';

abstract class BaseBloc<S extends BaseState> extends Cubit<S> {
  late AppLocalizations localizations;

  BaseBloc(super.initialState) {
    init();
  }

  void init() {}
}
