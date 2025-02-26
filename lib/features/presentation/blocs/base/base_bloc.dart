import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/i18n/strings.g.dart';
part 'base_state.dart';

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S> {
  late Translations localizations;

  BaseBloc(super.initialState) {
    init();
  }

  void init() {}
}
