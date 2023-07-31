import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';

void showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Image.network(
          imageUrl,
          headers: GlobalConstants.header(),
        ),
      );
    },
  );
}
