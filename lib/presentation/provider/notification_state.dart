import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationState extends ChangeNotifier {
  showErrorToast(String text, bool isError) {
    showSimpleNotification(
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontFamily: 'CustomIcons',
        ),
      ),
      leading: const Icon(
        Icons.error_outline,
        color: Colors.white,
        size: 25.0,
      ),
      background: isError ? Colors.red : Colors.green,
      elevation: 0.0,
      slideDismissDirection: DismissDirection.up,
    );
    notifyListeners();
  }
}
