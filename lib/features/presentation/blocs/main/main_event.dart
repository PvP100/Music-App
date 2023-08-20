part of 'main_bloc.dart';

abstract class MainEvent {}

class OnTabClickEvent extends MainEvent {
  final TabNavigation screen;

  OnTabClickEvent(this.screen);
}
