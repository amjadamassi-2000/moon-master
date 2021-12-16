import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';

class CustomBtnComponent extends StatefulWidget {
  final String text;
  final Function onTap;

  CustomBtnComponent({@required this.text, @required this.onTap});

  @override
  _CustomBtnComponentState createState() => _CustomBtnComponentState();
}

class _CustomBtnComponentState extends State<CustomBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: ArgonButton(
        height: AppShared.isTablet ? 100 : 50,
        width: MediaQuery.of(context).size.width * 0.9,
        borderRadius: 5.0,
        color: Theme.of(context).primaryColor,
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppShared.isTablet ? AppShared.screenUtil.setSp(40) : 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        loader: CircularProgressIndicator(),
        onTap: (startLoading, stopLoading, btnState) {
          widget.onTap(startLoading, stopLoading, btnState);
        },
      ),
    );
  }
}
