import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/helpers.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(child: ProfileScreenBody());
  }
}

class ProfileScreenBody extends StatelessWidget {
  Widget buildItemInfo(BuildContext context, String title, String info,
      {IconData iconData, Widget image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          iconData == null
              ? image
              : Icon(
                  iconData,
                  size: AppShared.isTablet ? 60 : 20,
                  color: Theme.of(context).primaryColor,
                ),
          SizedBox(
            width: AppShared.isTablet ? 20 : 10,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppShared.isTablet ? 35 : 17,
            ),
          ),
          Spacer(),
          Text(
            info,
            style: TextStyle(
                color: Colors.black,
                fontSize: AppShared.isTablet ? 35 : 17,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.25,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(27),
                          bottomLeft: Radius.circular(27))),
                  width: double.infinity,
                  height: mediaQuery.size.height * 0.2,
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: AppShared.isTablet ? 110 : 62,
                      child: CircleAvatar(
                        radius: AppShared.isTablet ? 100 : 52,
                        backgroundImage: NetworkImage(
                          AppShared.currentUser.imageProfile,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),


          AppShared.currentUser.name == null ?
          Text(
              AppShared.currentUser.name ,

            style: TextStyle(
                color: Colors.black,
                fontSize: AppShared.isTablet ? 45 : 24,
                fontWeight: FontWeight.w600
            ),
            textAlign: TextAlign.center,
          ) :
              Text(""),



          SizedBox(
            height: 10,
          ),
          Text(
            AppShared.currentUser.email,
            style: TextStyle(
                color: const Color(0xffA2A2A2),
                fontSize: AppShared.isTablet ? 25 : 13),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            color: const Color(0xffF7F0DD),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppShared.appLang['PersonalInformation'],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppShared.isTablet ? 40 : 18,
                  ),
                ),
                SvgPicture.asset(
                  '${Constants.ASSETS_IMAGES_PATH}contact_form.svg',
                  fit: BoxFit.cover,
                  width: AppShared.isTablet ? 40 : 20,
                  height: AppShared.isTablet ? 40 : 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildItemInfo(
            context,
            AppShared.appLang['City'],


            Helpers.getCityById(AppShared.currentUser.cityId).name ?? "",





            iconData: Icons.location_on,
          ),
          SizedBox(
            height: 15,
          ),
          buildItemInfo(
            context,
            AppShared.appLang['MobileNumber'],
            AppShared.currentUser.mobile,
            image: SvgPicture.asset(
              '${Constants.ASSETS_IMAGES_PATH}phone.svg',
              width: AppShared.isTablet ? 40 : 20,
              height: AppShared.isTablet ? 40 : 20,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(15),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(),
                    ),
                  );
                },
                child: Text(
                  AppShared.appLang['EditProfile'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppShared.isTablet ? 35 : 16,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
