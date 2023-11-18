import 'package:flutter/material.dart';

Future<bool?> confirmDismissDialog(BuildContext context, int index, String title) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("$title will be deleted"),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("CANCEL"),
        ),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true), child: const Text("DELETE")),
      ],
    ),
  );
}
