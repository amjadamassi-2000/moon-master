import 'package:flutter/material.dart';
import 'package:moonapp/src/models/api_models/sub_models/addition.dart';
import 'package:moonapp/src/notifiers/screens_notifiers/customer_screens_notifiers/coffee_section_screens_notifiers/addition_screen_notifiers.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:provider/provider.dart';

class AdditionComponent extends StatelessWidget {
  final Addition addition;

  AdditionComponent(this.addition);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addition,
      child: AdditionComponentBody(),
    );
  }
}

class AdditionComponentBody extends StatefulWidget {
  @override
  _AdditionComponentBodyState createState() => _AdditionComponentBodyState();
}

class _AdditionComponentBodyState extends State<AdditionComponentBody> {
  Addition _addition;
  AdditionScreenNotifiers _additionScreenNotifiers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _additionScreenNotifiers =
        Provider.of<AdditionScreenNotifiers>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _addition = Provider.of<Addition>(context, listen: false);
    return Container(
      child: Row(
        children: <Widget>[
          Selector<Addition, bool>(
            selector: (_, value) => value.isSelected,
            builder: (_, isSelected, __) => InkWell(
              onTap: () {
                _addition.isSelected = !isSelected;
                if (!_addition.isSelected) {
                  _additionScreenNotifiers.onAdditionUnselected(_addition);
                  _addition.addAdditionRequest(quantity: 0);
                  _addition.quantity = 0;
                }
              },
              child: Container(
                width: AppShared.isTablet ? 40 : 20,
                height: AppShared.isTablet ? 40 : 20,
                color: Colors.grey[200],
                child: isSelected
                    ? Image.asset(
                        '${Constants.ASSETS_IMAGES_PATH}check.png',
                        width: AppShared.isTablet ? 40 : 20,
                        height: AppShared.isTablet ? 40 : 20,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _addition.addition.name,
                style: TextStyle(
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(45) : 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${_addition.addition.price} ${AppShared.appLang['SAR']}',
                style: TextStyle(
                  fontSize:
                      AppShared.isTablet ? AppShared.screenUtil.setSp(35) : 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Selector<Addition, int>(
                selector: (_, value) => value.quantity,
                builder: (_, quantity, __) => Text(
                  ' ${AppShared.appLang['Total']} : ${_addition.addition.price * quantity} ${AppShared.appLang['SAR']}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppShared.isTablet
                        ? AppShared.screenUtil.setSp(35)
                        : 16,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Selector<Addition, bool>(
            selector: (_, value) => value.isSelected,
            builder: (_, isSelected, __) => Row(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  decoration: BoxDecoration(
                      color: !isSelected
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppShared.isTablet ? 30 : 15))),
                  child: Center(
                      child: InkWell(
                    onTap: !isSelected
                        ? null
                        : () {
                            if (_addition.quantity == 0) return;
                            _addition.changeQuantity(
                                Constants.CHANGE_QUANTITY_TYPE_DECREMENT);
                            _additionScreenNotifiers.onQuantityChanged(
                              _addition.addition.price,
                              Constants.CHANGE_QUANTITY_TYPE_DECREMENT,
                            );
                          },
                    child: Icon(
                      Icons.remove,
                      size: AppShared.isTablet ? 30 : 15,
                      color: Colors.white,
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Selector<Addition, int>(
                  selector: (_, value) => value.quantity,
                  builder: (_, quantity, __) => Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: AppShared.isTablet
                          ? AppShared.screenUtil.setSp(40)
                          : 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                  decoration: BoxDecoration(
                      color: !isSelected
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppShared.isTablet ? 30 : 15))),
                  child: Center(
                      child: InkWell(
                    onTap: !isSelected
                        ? null
                        : () {
                            _addition.changeQuantity(
                                Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
                            _additionScreenNotifiers.onQuantityChanged(
                                _addition.addition.price,
                                Constants.CHANGE_QUANTITY_TYPE_INCREMENT);
                          },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: AppShared.isTablet ? 30 : 15,
                    ),



                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
