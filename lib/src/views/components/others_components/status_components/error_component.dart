import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';

// ignore: must_be_immutable
class ErrorComponent extends StatelessWidget {
  String _message;

  ErrorComponent({String message}) {
    this._message = message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: AppShared.screenUtil.setWidth(150),
          ),
          SizedBox(
            height: AppShared.screenUtil.setHeight(20),
          ),
          Text(_message),
        ],
      ),
    );
  }
}
