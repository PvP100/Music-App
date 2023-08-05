import 'package:flutter/widgets.dart';
import 'package:music_app/features/presentation/ui/dialogs/loading_dialog.dart';

class LoadingIndicator {
  static bool isShowing = false;

  static show(BuildContext context) async {
    if (!isShowing) {
      isShowing = true;
      showGeneralDialog(
          barrierDismissible: false,
          context: context,
          pageBuilder: ((context, animation, secondaryAnimation) =>
              const LoadingDialog()));
    }
  }

  static dismiss(BuildContext context) {
    if (isShowing) {
      Navigator.of(context).pop();
      isShowing = false;
    }
  }
}
