import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/helpers.dart';

// ignore: must_be_immutable
class ParentComponent extends StatelessWidget {
  Widget child;
  String _currentLang = AppShared.sharedPreferencesController.getAppLang();

  ParentComponent({this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Directionality(
        textDirection: Helpers.getDirectionByLang(_currentLang),
        child: child,
      ),
    );
  }
}
