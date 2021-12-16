import 'package:flutter/material.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:shimmer/shimmer.dart';

class SliderLoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyles.defaultPadding2,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Column(
          children: <Widget>[
            Container(
              height: 180,
              color: Colors.grey,
            ),
            Container(
              height: 10,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index2) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
