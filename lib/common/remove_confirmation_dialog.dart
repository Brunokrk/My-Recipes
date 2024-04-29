import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(BuildContext context, {required String content, required String affirmativeOption, required TextStyle textStyle}) {
  // Usando showDialog<bool> para garantir que o tipo de retorno é Future<bool?>
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(content, style: textStyle),
        actions: <Widget>[
          TextButton(
            child: Text(affirmativeOption),
            onPressed: () {
              Navigator.of(context).pop(true); //  true quando confirmar
            },
          ),
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false); // false quando cancelar
            },
          ),
        ],
      );
    },
  );
}
