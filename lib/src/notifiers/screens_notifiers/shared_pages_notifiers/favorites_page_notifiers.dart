import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/favorite_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class FavoritesPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isLoading = true;
  bool _isPagingLoading = false;
  bool _isNewDataLoaded = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isPagingLoading => _isPagingLoading;

  set isPagingLoading(bool value) {
    _isPagingLoading = value;
    notifyListeners();
  }

  bool get isNewDataLoaded => _isNewDataLoaded;

  set isNewDataLoaded(bool value) {
    _isNewDataLoaded = value;
    notifyListeners();
  }

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController _productsController;
  ScrollController productsScrollController;
  bool canLoadNewPage = true;
  int page = 1;
  FavoriteResponse favoriteResponse;

  bool isError = false;

  // ||... constructor ...||
  FavoritesPageNotifiers(this.context) {
    _productsController = ProductsController.instance;
    productsScrollController = ScrollController();
    productsScrollController.addListener(() {
      if (productsScrollController.position.pixels ==
          productsScrollController.position.maxScrollExtent) {
        if (!canLoadNewPage) return;
        page++;
        getFavorites();
      }
    });
  }

// ||...................... logic methods ............................||

  // init.
  void init({bool isInit = true}) async {
    try {
      if (!isInit) {
        isError = false;
        isLoading = true;
      }
      favoriteResponse = await _productsController.getFavoritesProducts(page);
      isLoading = false;

    }
    catch (error) {
      isError = true;
      isLoading = false;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }
 }

  // get favorites
  void getFavorites() async {
    if (page > favoriteResponse.products.lastPage) return;
    isPagingLoading = true;
    FavoriteResponse response =
        await _productsController.getFavoritesProducts(page);
    isPagingLoading = false;
    if (response.products.data.isEmpty) {
      canLoadNewPage = false;
      return;
    }
    favoriteResponse.products.data.addAll(response.products.data);
    isNewDataLoaded = !isNewDataLoaded;
  }



  // on un  favorite.
  void onUnFavorite(int index) {
    favoriteResponse.products.data.removeAt(index);
    isNewDataLoaded = !isNewDataLoaded;
  }

// ||...................... logic methods ............................||
}
