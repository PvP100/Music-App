import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/custom/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/core.dart';

abstract class BaseScreenState<V extends StatefulWidget,
        B extends BaseBloc<Object, S>, S extends BaseState> extends State<V>
    with RouteAware, WidgetsBindingObserver {
  late B _bloc;

  B get bloc => _bloc;

  @protected
  late AppLocalizations _localizations;

  AppLocalizations get localizations => _localizations;

  @protected
  Widget buildContent(BuildContext context);

  @protected
  Widget? get footer => null;

  @protected
  bool get safeAreaTop => true;

  @protected
  bool get safeAreaBottom => true;

  @protected
  bool get safeAreaLeft => true;

  @protected
  bool get safeAreaRight => true;

  @protected
  Color get backgroundColor => Colors.white;

  bool isFirstInit = true;

  @override
  void initState() {
    debugPrint("initState $runtimeType");
    WidgetsBinding.instance.addObserver(this);
    _bloc = GetIt.I.get<B>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint("didChangeDependencies $runtimeType");
    if (isFirstInit && mounted) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        onReveiveArguments(args as Map<String, dynamic>);
      }
    }
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.detached) {
      onDetach();
    } else if (state == AppLifecycleState.inactive) {
      onInactive();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didPush() {
    debugPrint("didPush $runtimeType");
    super.didPush();
  }

  @override
  void didPushNext() {
    debugPrint("didPushNext $runtimeType");
    super.didPushNext();
  }

  @override
  void didPop() {
    debugPrint("didPop $runtimeType");
    super.didPop();
  }

  @override
  void didPopNext() {
    debugPrint("didPopNext $runtimeType");
    super.didPopNext();
  }

  @override
  void dispose() {
    debugPrint("dispose $runtimeType");
    routeObserver.unsubscribe(this);
    _bloc.close();
    super.dispose();
  }

  @protected
  Future<bool> willPopCallback() async {
    return !LoadingIndicator.isShowing;
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
    return Platform.isAndroid
        ? WillPopScope(onWillPop: (willPopCallback), child: _body(context))
        : _body(context);
  }

  Widget _body(BuildContext context) => BlocProvider.value(
        value: _bloc,
        child: BlocListener<B, S>(
            listener: (context, state) {
              if (state.isLoading) {
                LoadingIndicator.show(context);
              } else {
                LoadingIndicator.dismiss(context);
                if (state.errorMsg != null) {
                  context.showError(state.errorMsg);
                }
                onStateListener(context, state);
              }
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                top: safeAreaTop,
                bottom: safeAreaBottom,
                left: safeAreaLeft,
                right: safeAreaRight,
                child: Stack(
                  children: [
                    Positioned.fill(child: buildContent(context)),
                    if (footer != null) ...{
                      Positioned(bottom: 0, left: 0, right: 0, child: footer!)
                    }
                  ],
                ),
              ),
            )),
      );

  @protected
  void onStateListener(BuildContext context, S state) {}

  @protected
  void onReveiveArguments(Map<String, dynamic> arguments) {}

  @protected
  void onResume() {
    debugPrint("onResume $runtimeType");
  }

  @protected
  void onPause() {
    debugPrint("onPause $runtimeType");
  }

  @protected
  void onDetach() {
    debugPrint("onDetach $runtimeType");
  }

  @protected
  void onInactive() {
    debugPrint("onInactive $runtimeType");
  }
}
