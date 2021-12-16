import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/product.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';

class RelatedProductComponent extends StatelessWidget {
  final Product product;

  RelatedProductComponent({@required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (AppShared.sharedPreferencesController.getSectionType() ==
            Constants.SECTION_TYPE_COFFEE)
          Navigator.pushNamed(
            context,
            Constants.SCREENS_COFFEE_PRODUCT_DETAILS_SCREEN,
            arguments: product,
          );
        else if (AppShared.sharedPreferencesController.getSectionType() ==
            Constants.SECTION_TYPE_STORE)
          Navigator.pushNamed(
            context,
            Constants.SCREENS_STORE_PRODUCT_DETAILS_SCREEN,
            arguments: product,
          );
        else
          Navigator.pushNamed(
            context,
            Constants.SCREENS_BEAUTY_SERVICE_DETAILS_SCREEN,
            arguments: product,
          );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: AppShared.isTablet ? 40 : 20,
            backgroundImage: NetworkImage(product.image),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(25)
                          : 12,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${product.discount == 0 ? product.price : product.discount} ${AppShared.appLang['SAR']}',
                    style: TextStyle(
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(20)
                          : 10,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
