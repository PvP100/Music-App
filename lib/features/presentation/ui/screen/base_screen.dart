import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class BaseScreen<B extends BaseBloc<Object, S>,
    S extends BaseState<S>> {
  final Map<String, dynamic>? arguments;

  late B _bloc;

  B get bloc => _bloc;

  @protected
  late AppLocalizations _localizations;

  AppLocalizations get localizations => _localizations;

  BaseScreen({this.arguments});

  late BuildContext _context;

  BuildContext get context => _context;

  @protected
  void initState(B screenBloc) {
    _bloc = screenBloc;
  }

  @protected
  void onStateListener(BuildContext ctx, S state) {}

  @protected
  void dispose() {
    _bloc.close();
  }

  @protected
  Widget buildChild();

  Widget buildParent() {
    return BaseParentWidget(
      onStateListener: onStateListener,
      buildCallBack: _buildCallBack,
      initStateCallBack: initState,
      disposeCallBack: dispose,
    );
  }

  _buildCallBack(BuildContext ctx, ValueChanged<Widget> buildWidget) {
    _context = ctx;
    _localizations = AppLocalizations.of(context)!;
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
  });

  final Function(BuildContext, ValueChanged<Widget>) buildCallBack;
  final ValueChanged<B> initStateCallBack;
  final VoidCallback disposeCallBack;
  final Function(BuildContext, S) onStateListener;

  @override
  State<BaseParentWidget<B, S>> createState() =>
      _BaseParentWidgetState<BaseParentWidget<B, S>, B, S>();
}

class _BaseParentWidgetState<W extends BaseParentWidget<B, S>,
    B extends BaseBloc<Object, S>, S extends BaseState> extends State<W> {
  late B _bloc;

  @override
  void initState() {
    _bloc = GetIt.I.get<B>();
    super.initState();
    widget.initStateCallBack(_bloc);
  }

  @override
  void dispose() {
    widget.disposeCallBack();
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
      child: BlocListener<B, S>(listener: widget.onStateListener, child: child),
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
