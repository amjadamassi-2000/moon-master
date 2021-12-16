import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class InfoComponent extends StatelessWidget {
  final InfoComponentType infoComponentType;
  final String title;
  final String description;
  final Function buttonOnTap;
  final String buttonTitle;

  InfoComponent({
    this.infoComponentType,
    this.description,
    this.title,
    this.buttonOnTap,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            Helpers.getImageForInfoComponentType(infoComponentType),
            width: AppShared.isTablet ? 400 : 200,
            height: AppShared.isTablet ? 400 : 200,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: AppShared.isTablet ? 35 : 25),
          ),
          SizedBox(
            height: 15,
          ),
          description == null
              ? Container()
              : Text(
                  description,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 14, color: const Color(0xffA2A2A2)),
                ),
          SizedBox(
            height: 15,
          ),
          buttonTitle == null
              ? Container()
              : InkWell(
                  onTap: buttonOnTap,
                  child: Text(
                    buttonTitle,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor,
                      fontSize: AppShared.isTablet ? 25 : 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
