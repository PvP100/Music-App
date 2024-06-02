import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/common_widgets/loading/custom_loading.dart';
import 'package:music_app/features/presentation/ui/custom/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';

abstract class BaseScreenState<V extends StatefulWidget, B extends BaseBloc<S>,
        S extends BaseState> extends State<V>
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
  Color get backgroundColor => AppColors.primaryBackgroundColor;

  bool isFirstInit = true;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @override
  void initState() {
    _bloc = GetIt.I.get<B>();
    flutterDebugPrint("initState $runtimeType");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    flutterDebugPrint("didChangeDependencies $runtimeType");
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
  void didUpdateWidget(covariant V oldWidget) {
    flutterDebugPrint("didUpdateWidget $runtimeType");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didPush() {
    flutterDebugPrint("didPush $runtimeType");
    super.didPush();
  }

  @override
  void didPushNext() {
    flutterDebugPrint("didPushNext $runtimeType");
    super.didPushNext();
  }

  @override
  void didPop() {
    flutterDebugPrint("didPop $runtimeType");
    super.didPop();
  }

  @override
  void didPopNext() {
    flutterDebugPrint("didPopNext $runtimeType");
    super.didPopNext();
  }

  @override
  void dispose() {
    flutterDebugPrint("dispose $runtimeType");
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
    flutterDebugPrint("build $runtimeType");
    _localizations = AppLocalizations.of(context)!;
    bloc.localizations = _localizations;
    return Platform.isAndroid
        ? WillPopScope(onWillPop: (willPopCallback), child: _body(context))
        : _body(context);
  }

  Widget _body(BuildContext context) => BlocProvider.value(
        value: _bloc,
        child: BlocListener<B, S>(
            listener: (context, state) {
              if (state.isLoading) {
                CustomLoading.show();
              } else {
                CustomLoading.dismiss();
                if (state.error != null) {
                  context.handleError(state.error!);
                }
                onStateListener(context, state);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
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
    flutterDebugPrint("onResume $runtimeType");
  }

  @protected
  void onPause() {
    flutterDebugPrint("onPause $runtimeType");
  }

  @protected
  void onDetach() {
    flutterDebugPrint("onDetach $runtimeType");
  }

  @protected
  void onInactive() {
    flutterDebugPrint("onInactive $runtimeType");
  }
}
