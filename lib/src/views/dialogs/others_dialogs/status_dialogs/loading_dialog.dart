import 'package:flutter/material.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:moonapp/src/views/components/others_components/status_components/loading_component.dart';

class LoadingDialog extends StatelessWidget {
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
        content: LoadingComponent(),
      ),
    );
  }
}
