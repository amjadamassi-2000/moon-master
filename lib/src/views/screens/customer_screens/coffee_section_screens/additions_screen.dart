import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/addition_screen_notifiers.dart';
import 'package:moonapp/src/styles/app_styles.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/views/components/customer_components/coffee_section_components/addition_component.dart';
import 'package:moonapp/src/views/components/others_components/parent_component.dart';
import 'package:provider/provider.dart';

class AdditionScreen extends StatelessWidget {
  Cart cart;

  @override
  Widget build(BuildContext context) {
    cart = ModalRoute.of(context).settings.arguments;
    return ParentComponent(
      child: ChangeNotifierProvider<AdditionScreenNotifiers>(
        create: (_) => AdditionScreenNotifiers(context, cart),
        child: AdditionScreenBody(),
      ),
    );
  }
}

class AdditionScreenBody extends StatefulWidget {
  @override
  _AdditionScreenBodyState createState() => _AdditionScreenBodyState();
}

class _AdditionScreenBodyState extends State<AdditionScreenBody> {
  AdditionScreenNotifiers _additionScreenNotifiers;
  double _textStyle = AppShared.isTablet ? AppShared.screenUtil.setSp(50) : 16;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _additionScreenNotifiers =
        Provider.of<AdditionScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          AppShared.appLang['Additions'],
          style: TextStyle(
            fontSize: _textStyle,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: AppStyles.defaultPadding3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: AppStyles.defaultPadding2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: AppShared.isTablet ? 150 : 78,
                                height: AppShared.isTablet ? 150 : 78,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        _additionScreenNotifiers
                                            .cart.product.image,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xffE4E4E4))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _additionScreenNotifiers.cart.product.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: _textStyle,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '${AppShared.appLang['Quantity']} : ${_additionScreenNotifiers.cart.quantity} | ${_additionScreenNotifiers.cart.product.price} SAR',
                                    style: TextStyle(
                                        fontSize: AppShared.isTablet
                                            ? AppShared.screenUtil.setSp(40)
                                            : 11,
                                        color: const Color(0xffA2A2A2)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${AppShared.appLang['Total']} :  ${_additionScreenNotifiers.cart.product.price * _additionScreenNotifiers.cart.quantity} Sar',
                                    style: TextStyle(
                                        fontSize: AppShared.isTablet
                                            ? AppShared.screenUtil.setSp(45)
                                            : 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: AppShared.isTablet ? 30 : 15,
                                child: Text(
                                  '${_additionScreenNotifiers.cart.quantity}',
                                  style: TextStyle(
                                    fontSize: AppShared.isTablet
                                        ? AppShared.screenUtil.setSp(45)
                                        : 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  '${AppShared.appLang['Additions']} : ',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(50)
                        : 18,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _additionScreenNotifiers.cart.additions.length,
                itemBuilder: (_, index) => Column(
                  children: <Widget>[
                    AdditionComponent(
                      _additionScreenNotifiers.cart.additions[index],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${AppShared.appLang['SubTotal']} :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(40)
                          : 14,
                    ),
                  ),
                  Selector<AdditionScreenNotifiers, num>(
                    selector: (_, value) => value.subTotal,
                    builder: (_, total, __) => Text(
                      '${_additionScreenNotifiers.subTotal} ${AppShared.appLang['SAR']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(45)
                              : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${AppShared.appLang['TotalAdditions']} :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(40)
                          : 14,
                    ),
                  ),
                  Selector<AdditionScreenNotifiers, num>(
                    selector: (_, value) => value.totalAdditions,
                    builder: (_, totalAdditions, __) => Text(
                      '$totalAdditions ${AppShared.appLang['SAR']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(45)
                              : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${AppShared.appLang['Total']} :',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(40)
                          : 14,
                    ),
                  ),
                  Selector<AdditionScreenNotifiers, num>(
                    selector: (_, value) => value.total,
                    builder: (_, total, __) => Text(
                      '$total ${AppShared.appLang['SAR']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: AppShared.isTablet
                              ? AppShared.screenUtil.setSp(45)
                              : 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
