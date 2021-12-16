import 'package:flutter/material.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/success_component.dart';

class SuccessDialog extends StatelessWidget {
  final String message;

  SuccessDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        content: SuccessComponent(message: message),
      ),
    );
  }
}
