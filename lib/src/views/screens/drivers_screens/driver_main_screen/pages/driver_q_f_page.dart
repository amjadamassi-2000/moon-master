import 'package:flutter/material.dart';
import 'package:moonapp/src/views/screens/shared_pages/ZoomDrawerController.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/helpers.dart';

class DriverQFPage extends StatelessWidget {
  final ZoomDrawerController _zoomDrawerController;

  DriverQFPage(this._zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return DriverQFPageBody(_zoomDrawerController);
  }
}

class DriverQFPageBody extends StatefulWidget {
  final ZoomDrawerController _zoomDrawerController;

  DriverQFPageBody(this._zoomDrawerController);

  @override
  _DriverQFPageBodyState createState() => _DriverQFPageBodyState();
}

class _DriverQFPageBodyState extends State<DriverQFPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          'Q&F',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Helpers.handleDrawer(widget._zoomDrawerController);
          },
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (_, index) => Column(
            children: <Widget>[
              Container(
                color: const Color(0xffF7F0DD),
                child: ExpansionTile(
                  title: Text(
                    'Q1 : What is store ?',
                    style: TextStyle(color: Colors.black),
                  ),
                  children: <Widget>[
                    Container(
                      padding: AppStyles.defaultPadding2,
                      child: Text(
                        'Contrary to popular belief, Lorem Ipsum is nghhhot simpte. It\n has roots in a piece of classical Latin \nliterature from 45 BC, making ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
