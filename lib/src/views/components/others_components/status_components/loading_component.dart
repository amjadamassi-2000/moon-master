import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:moonapp/src/utils/app_shared.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppShared.screenUtil.setHeight(AppShared.isTablet ? 700 : 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadingBouncingGrid.square(
            size: AppShared.isTablet ? 100 : 50,
            borderColor: Colors.yellow[600],
            backgroundColor: Colors.yellow[600],
          ),
          SizedBox(
            height: AppShared.isTablet ? 20 : 5,
          ),
          Text(
            AppShared.appLang['Loading'],
            style: TextStyle(
              fontSize:
                  AppShared.isTablet ? AppShared.screenUtil.setSp(40) : 16,
            ),
          ),
        ],
      ),
    );
  }
}
