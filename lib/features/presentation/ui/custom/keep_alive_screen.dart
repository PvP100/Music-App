import 'package:flutter/material.dart';

class KeepAliveScreen extends StatefulWidget {
  const KeepAliveScreen({super.key, required this.child});

  final Widget child;

  @override
  State<KeepAliveScreen> createState() => _KeepAliveScreenState();
}

class _KeepAliveScreenState extends State<KeepAliveScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
