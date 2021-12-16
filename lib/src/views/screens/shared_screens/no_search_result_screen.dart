import 'package:flutter/material.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';

class NoSearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ParentComponent(
      child: NoSearchResultScreenBody(),
    );
  }
}

class NoSearchResultScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).padding.top,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              BackButton(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: const Color(0xffF7F0DD),
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Image.asset(
                            '${Constants.ASSETS_IMAGES_PATH}search.png')),
                  ),
                ),
              ))
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    '${Constants.ASSETS_IMAGES_PATH}noResultSearch.png',
                    fit: BoxFit.cover,
                    width: 172,
                    height: 195,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'no search results',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*
Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              '${Constants.ASSETS_IMAGES_PATH}noResultSearch.png',
              fit: BoxFit.cover,
              width: 172,
              height: 195,
            ),SizedBox(height: 15,),
            Text('no search results' , style: TextStyle(color: Colors.black , fontSize: 30),)
          ],
        ),
      ),
 */
