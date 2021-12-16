import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moonapp/src/utils/app_shared.dart';

class ReviewComponent extends StatelessWidget {
  final String date;
  final String by;
  final String content;
  final double rating;

  ReviewComponent({this.date, this.by, this.content, this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: const Color(0xffF7F0DD),
          child: Row(
            children: <Widget>[
              Container(
                child: RatingBar.builder(
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                  initialRating: rating,
                  ignoreGestures: true,
                  minRating: 1,
                  tapOnlyMode: true,
                  direction: Axis.horizontal,
                  itemSize: AppShared.isTablet ? 45 : 22,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),
              Text(
                ' (${rating.toInt()})',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(30) : 12,
                ),
              ),
              Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 13,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            content,
            style: TextStyle(
              fontSize:
                  AppShared.isTablet ? AppShared.screenUtil.setSp(40) : 15,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            by,
            style: TextStyle(
              fontSize:
                  AppShared.isTablet ? AppShared.screenUtil.setSp(30) : 13,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
