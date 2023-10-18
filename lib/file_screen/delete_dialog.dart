import 'package:flutter/material.dart';

class DeleteDialog {
  static void showDeleteDialog(BuildContext context,
      {required VoidCallback onDelete}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ConfirmDeleteDialog(onDelete: onDelete);
      },
    );
  }
}

class _ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  _ConfirmDeleteDialog({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Eliminar artículo'),
      content: Text('¿Estás seguro de que quieres eliminar este artículo?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
          },
        ),
        TextButton(
          child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          onPressed: () {
            onDelete();
            Navigator.of(context).pop(); // Dismiss the dialog after deleting
          },
        ),
      ],
    );
  }
}
