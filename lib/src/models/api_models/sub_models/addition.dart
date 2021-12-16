import 'package:flutter/foundation.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class Addition with ChangeNotifier {
  Addition({
    this.id,
    this.cartId,
    this.additionId,
    this.quantity,
    this.createdAt,
    this.addition,
  }) {
    _productsController = ProductsController.instance;
    isSelected = quantity > 0;
  }

  int id;
  int cartId;
  int additionId;
  //||.. notifiable ..||
  int quantity;
  DateTime createdAt;
  AdditionDetails addition;

  //||.. notifiable only vars..||
  bool _isSelected;

  //||.... private vars ...||
  ProductsController _productsController;

  factory Addition.fromJson(Map<String, dynamic> json) => Addition(
        id: json["id"],
        cartId: json["cart_id"],
        additionId: json["addition_id"],
        quantity: json["quantity"] == null ? 0 : json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        addition: AdditionDetails.fromJson(json["addition"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "addition_id": additionId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "addition": addition.toJson(),
      };

//||.. notifiable ..||

  void changeQuantity(int type) {
    if (type == Constants.CHANGE_QUANTITY_TYPE_INCREMENT) {
      quantity++;
//      addition.price++;
    } else {
      quantity--;
//      addition.price--;
    }
    addAdditionRequest(quantity: quantity);
    notifyListeners();
  }







  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  //||............... logic methods .......||
// add addition to product.
  void addAdditionRequest({
    @required int quantity,
  }) async {
   // try {
      BaseResponse baseResponse = await _productsController.addAddition(
        cartId: this.cartId,
        additionId: this.additionId,
        quantity: quantity,
      );
      if (baseResponse.status) {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_SUCCESS);
      } else {
        Helpers.showMessage(baseResponse.message, MessageType.MESSAGE_FAILED);
      }
    }
//    catch (error) {
//      print(error);
//      Helpers.showMessage(error.message, MessageType.MESSAGE_FAILED);
//    }
  }

//||............... logic methods .......||

//}

class AdditionDetails {
  AdditionDetails({
    this.id,
    this.price,
    this.status,
    this.createdAt,
    this.name,
  });

  int id;
  int price;
  String status;
  DateTime createdAt;
  String name;

  factory AdditionDetails.fromJson(Map<String, dynamic> json) =>
      AdditionDetails(
        id: json["id"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price == null ? null : price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "name": name,
      };
}
