import 'package:flutter/material.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState
    extends BaseScreenState<LibraryScreen, LibraryBloc, LibraryState> {
  @override
  Widget buildContent(BuildContext context) {
    return Container();
  }
}
