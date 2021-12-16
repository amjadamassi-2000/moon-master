import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/products_response.dart';

class SearchAboutProductScreenNotifiers with ChangeNotifier {
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
  // ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController _productsController;
  TextEditingController searchTextController;
  ScrollController productsScrollController;
  ProductsResponse productsResponse;
  bool canLoadNewPage = true;
  int page = 1;

  // ||... constructor ...||
  SearchAboutProductScreenNotifiers(this.context) {
    _productsController = ProductsController.instance;
    searchTextController = TextEditingController();
    productsScrollController = ScrollController();
    productsScrollController.addListener(() {
      if (productsScrollController.position.pixels ==
          productsScrollController.position.maxScrollExtent) {
        if (!canLoadNewPage) return;
        page++;
        if (searchTextController.text.isEmpty)
          getProducts();
        else
          search();
      }
    });
  }

// ||...................... logic methods ............................||

  // init
  void init() async {
    productsResponse = await _productsController.getProducts(0, page);
    isLoading = false;
  }

  // search about product.
  void search() async {
    if (page == 1) {
      isLoading = true;
      productsResponse = await _productsController.searchAboutProduct(
          searchTextController.text, page);
      isLoading = false;
    } else {
      if (page > productsResponse.products.lastPage) return;
      isPagingLoading = true;
      ProductsResponse response = await _productsController.searchAboutProduct(
          searchTextController.text, page);
      isPagingLoading = false;
      if (response.products.data.isEmpty) {
        canLoadNewPage = false;
        return;
      }
      productsResponse.products.data.addAll(response.products.data);
      isNewDataLoaded = !isNewDataLoaded;
    }
  }

  // get products by category id.
  void getProducts() async {
    if (page == 1) {
      isLoading = true;
      productsResponse = await _productsController.getProducts(0, page);
      isLoading = false;
    } else {
      if (page > productsResponse.products.lastPage) return;
      isPagingLoading = true;
      ProductsResponse response =
          await _productsController.getProducts(0, page);
      isPagingLoading = false;
      if (response.products.data.isEmpty) {
        canLoadNewPage = false;
        return;
      }
      productsResponse.products.data.addAll(response.products.data);
      isNewDataLoaded = !isNewDataLoaded;
    }
  }

// ||...................... logic methods ............................||

}
