import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingComponent extends StatelessWidget {
  final type;
  final isScrolling;

  ProductLoadingComponent({@required this.isScrolling, this.type = 1});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: type == 1
          ? GridView.builder(
              shrinkWrap: !isScrolling,
              physics: isScrolling ? null : NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppShared.isTablet ? 3 : 2,
                childAspectRatio: 1 / 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (_, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.favorite_border,
                        size: AppShared.isTablet ? 40 : 20,
                      ),
                    ),
                    Container(
                      height: AppShared.isTablet ? 180 : 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: AppShared.isTablet ? 15 : 10,
                      width: AppShared.isTablet ? 150 : 50,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: AppShared.isTablet ? 15 : 10,
                      width: AppShared.isTablet ? 150 : 50,
                      color: Colors.grey,
                    ),
                    Container(
                      width: double.infinity,
                      height: AppShared.isTablet ? 50 : null,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        onPressed: null,
                      ),
                    )
                  ],
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: !isScrolling,
              scrollDirection: Axis.horizontal,
              physics: isScrolling ? null : NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (_, index) => Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.favorite_border,
                            ),
                          ),
                          Container(
                            height: AppShared.isTablet ? 250 : 100,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: AppShared.isTablet ? 50 : 10,
                            width: AppShared.isTablet ? 200 : 50,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            height: AppShared.isTablet ? 50 : 10,
                            width: AppShared.isTablet ? 200 : 50,
                            color: Colors.grey,
                          ),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              onPressed: null,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
