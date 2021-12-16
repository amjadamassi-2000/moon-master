import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class CoffeeFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: CoffeeFilterScreenBody(),
    );
  }
}

class CoffeeFilterScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoffeeFilterScreenBodyState();
  }
}

class _CoffeeFilterScreenBodyState extends State<CoffeeFilterScreenBody> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Price Range :',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
          ),
          SizedBox(
            height: 17,
          ),
          Image.asset(
            '${Constants.ASSETS_IMAGES_PATH}progress.png',
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Category :',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Theme(
            data: ThemeData(primaryColor: const Color(0xffE5E5E5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                      color: Colors.black,
                    ),
                    hintText: 'Juices , Cake',
                    hintStyle: TextStyle(color: const Color(0xffA2A2A2))),
              ),
            ),
          ),
          SizedBox(
            height: 30,
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
          _sortByPrice('Low To High', showCheck: false),
          _sortByPrice('High To Low', showCheck: false),
          _sortByPrice('The Most Recent', showCheck: true),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OutlineButton(
                padding: const EdgeInsets.all(17),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Text(
                  'Clear',
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: RaisedButton(
                padding: const EdgeInsets.all(15),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
