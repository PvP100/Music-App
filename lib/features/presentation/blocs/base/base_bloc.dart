import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'base_state.dart';

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    init();
  }

  void init() {}
}
