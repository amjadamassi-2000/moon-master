import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class StoreFilterSecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: StoreFilterSecondScreenBody(),
    );
  }
}

class StoreFilterSecondScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoreFilterSecondScreenBodyState();
  }
}

class StoreFilterSecondScreenBodyState
    extends State<StoreFilterSecondScreenBody> {
  Widget _sortByPrice(String title, {bool showCheck = false}) {
    return ListTile(
      onTap: () {},
      leading: Text(
        title,
        style: TextStyle(
            color: showCheck
                ? Theme.of(context).primaryColor
                : const Color(0xffA2A2A2),
            fontSize: 15),
      ),
      trailing: !showCheck
          ? null
          : Image.asset(
              '${Constants.ASSETS_IMAGES_PATH}check.png',
              fit: BoxFit.cover,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Filter',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Sort By Price :',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _sortByPrice('Still Preparation', showCheck: false),
          _sortByPrice('Ready', showCheck: false),
          _sortByPrice('Still Delivery', showCheck: true),
          _sortByPrice('complete', showCheck: false),
        ],
      ),
    );
  }
}
