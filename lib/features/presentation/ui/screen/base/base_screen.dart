import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/i18n/strings.g.dart' show Translations;

import '../../../../../core/core.dart';
import '../../custom/loading_indicator.dart';

typedef DebugModePrint = void Function(String? message);

DebugModePrint debugModePrint = debugModePrintFunction;

void debugModePrintFunction(String? message) {
  if (kDebugMode) {
    print(message);
  }
}

abstract class BaseScreen<B extends BaseBloc<Object, S>,
    S extends BaseState<S>> {
  final Map<String, dynamic>? arguments;

  late B _bloc;

  B get bloc => _bloc;

  @protected
  late Translations _localizations;

  Translations get localizations => _localizations;

  BaseScreen({this.arguments});

  late BuildContext _context;

  BuildContext get context => _context;

  @protected
  void initState(B screenBloc) {
    debugModePrint("initState");
    _bloc = screenBloc;
  }

  @protected
  void onStateListener(BuildContext ctx, S state) {}

  @protected
  void dispose() {
    debugModePrint("dispose");
    _bloc.close();
  }

  @protected
  void onResume() {
    debugModePrint("onResume");
  }

  @protected
  void onPause() {
    debugModePrint("onPause");
  }

  @protected
  void onDetach() {
    debugModePrint("onDetach");
  }

  @protected
  void onInactive() {
    debugModePrint("onInactive");
  }

  @protected
  void didPush() {
    debugModePrint("didPush");
  }

  @protected
  void didPushNext() {
    debugModePrint("didPushNext");
  }

  @protected
  void didPop() {
    debugModePrint("didPop");
  }

  @protected
  void didPopNext() {
    debugModePrint("didPopNext");
  }

  @protected
  Widget buildChild();

  Widget buildParent() {
    return BaseParentWidget(
      onStateListener: onStateListener,
      buildCallBack: _buildCallBack,
      initStateCallBack: initState,
      disposeCallBack: dispose,
      onResume: onResume,
      onPause: onPause,
      onDetach: onDetach,
      onInactive: onInactive,
      didPush: didPush,
      didPop: didPop,
      didPushNext: didPushNext,
      didPopNext: didPopNext,
    );
  }

  _buildCallBack(BuildContext ctx, ValueChanged<Widget> buildWidget) {
    _context = ctx;
    _localizations = Translations.of(context);
    bloc.localizations = _localizations;
    buildWidget(buildChild());
  }
}

class BaseParentWidget<B extends BaseBloc<Object, S>, S extends BaseState>
    extends StatefulWidget {
  const BaseParentWidget({
    super.key,
    required this.buildCallBack,
    required this.initStateCallBack,
    required this.disposeCallBack,
    required this.onStateListener,
    required this.onResume,
    required this.onPause,
    required this.onDetach,
    required this.onInactive,
    required this.didPush,
    required this.didPop,
    required this.didPushNext,
    required this.didPopNext,
  });

  final Function(BuildContext, ValueChanged<Widget>) buildCallBack;
  final ValueChanged<B> initStateCallBack;
  final VoidCallback disposeCallBack;
  final Function(BuildContext, S) onStateListener;
  final VoidCallback onResume;
  final VoidCallback onPause;
  final VoidCallback onDetach;
  final VoidCallback onInactive;
  final VoidCallback didPush;
  final VoidCallback didPop;
  final VoidCallback didPushNext;
  final VoidCallback didPopNext;

  @override
  State<BaseParentWidget<B, S>> createState() =>
      _BaseParentWidgetState<BaseParentWidget<B, S>, B, S>();
}

class _BaseParentWidgetState<W extends BaseParentWidget<B, S>,
        B extends BaseBloc<Object, S>, S extends BaseState> extends State<W>
    with RouteAware, WidgetsBindingObserver {
  late B _bloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _bloc = GetIt.I.get<B>();
    super.initState();
    widget.initStateCallBack(_bloc);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onResume();
    } else if (state == AppLifecycleState.paused) {
      widget.onPause();
    } else if (state == AppLifecycleState.detached) {
      widget.onDetach();
    } else if (state == AppLifecycleState.inactive) {
      widget.onInactive();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didPush() {
    widget.didPush();
    super.didPush();
  }

  @override
  void didPushNext() {
    widget.didPushNext();
    super.didPushNext();
  }

  @override
  void didPop() {
    widget.didPop();
    super.didPop();
  }

  @override
  void didPopNext() {
    widget.didPopNext();
    super.didPopNext();
  }

  @override
  void dispose() {
    widget.disposeCallBack();
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late Widget child;
    widget.buildCallBack(context, (w) {
      child = w;
    });
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<B, S>(
        listener: (context, state) {
          if (state.isLoading) {
            LoadingIndicator.show(context);
          } else {
            LoadingIndicator.dismiss(context);
            if (state.error != null) {
              context.showError(state.error!);
            }
            widget.onStateListener(context, state);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}

abstract class BaseScreenWithSingleTickerProvider<B extends BaseBloc<Object, S>,
    S extends BaseState<S>> extends BaseScreen<B, S> {
  BaseScreenWithSingleTickerProvider({super.arguments});

  late SingleTickerProviderStateMixin _singleTickerProviderStateMixin;

  SingleTickerProviderStateMixin get singleTickerProviderStateMixin =>
      _singleTickerProviderStateMixin;

  @override
  Widget buildParent() {
    return BaseParentWidgetWithSingleTickerProvider<B, S>(
      onStateListener: onStateListener,
      buildCallBack: _buildCallBack,
      initStateCallBack: initState,
      disposeCallBack: dispose,
      initSingleTickerProvider: _initSingleTickerProvider,
      onResume: onResume,
      onPause: onPause,
      onDetach: onDetach,
      onInactive: onInactive,
      didPush: didPush,
      didPop: didPop,
      didPushNext: didPushNext,
      didPopNext: didPopNext,
    );
  }

  _initSingleTickerProvider(SingleTickerProviderStateMixin singleTicker) {
    _singleTickerProviderStateMixin = singleTicker;
  }
}

class BaseParentWidgetWithSingleTickerProvider<B extends BaseBloc<Object, S>,
    S extends BaseState> extends BaseParentWidget<B, S> {
  final Function(SingleTickerProviderStateMixin) initSingleTickerProvider;

  const BaseParentWidgetWithSingleTickerProvider({
    super.key,
    required super.buildCallBack,
    required super.initStateCallBack,
    required super.disposeCallBack,
    required super.onStateListener,
    required this.initSingleTickerProvider,
    required super.onResume,
    required super.onPause,
    required super.onDetach,
    required super.onInactive,
    required super.didPush,
    required super.didPop,
    required super.didPushNext,
    required super.didPopNext,
  });

  @override
  State<BaseParentWidgetWithSingleTickerProvider<B, S>> createState() =>
      _BaseParentWidgetStateWithSingleTickerProvider<B, S>();
}

class _BaseParentWidgetStateWithSingleTickerProvider<
        B extends BaseBloc<Object, S>, S extends BaseState>
    extends _BaseParentWidgetState<
        BaseParentWidgetWithSingleTickerProvider<B, S>,
        B,
        S> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.initSingleTickerProvider(this);
    super.initState();
  }
}
