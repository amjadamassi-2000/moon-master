import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/products_controller.dart';
import 'package:moonapp/src/controllers/api_controllers/customer_controllers/shared_controllers/slider_controller.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/products_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/slider_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';
import 'package:moonapp/src/utils/enums.dart';
import 'package:moonapp/src/utils/helpers.dart';

class BeautyHomeTabPageNotifiers with ChangeNotifier {
  // ||....................... notifiable ..................................||
  bool _isSliderLoading = true;
  bool _isProductsLoading = true;
  bool _isPagingLoading = false;
  bool _isNewDataLoaded = false;
  int _selectedSlider = 0;
  bool _isError = false;

  bool get isSliderLoading => _isSliderLoading;

  set isSliderLoading(bool value) {
    _isSliderLoading = value;
    notifyListeners();
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  bool get isProductsLoading => _isProductsLoading;

  set isProductsLoading(bool value) {
    _isProductsLoading = value;
    notifyListeners();
  }

  bool get isNewDataLoaded => _isNewDataLoaded;

  set isNewDataLoaded(bool value) {
    _isNewDataLoaded = value;
    notifyListeners();
  }

  bool get isPagingLoading => _isPagingLoading;

  set isPagingLoading(bool value) {
    _isPagingLoading = value;
    notifyListeners();
  }

  int get selectedSlider => _selectedSlider;

  set selectedSlider(int value) {
    _selectedSlider = value;
    notifyListeners();
  }
// ||....................... notifiable ..................................||

//--------------------------------------------------------------------------------------------------//

  BuildContext context;
  ProductsController productsController;
  SliderController sliderController;
  ScrollController productsScrollController;
  bool canLoadNewPage = true;
  SliderResponse coffeeSliderResponse;
  ProductsResponse productsResponse;
  int selectedCategory = 0;
  int page = 1;

  // ||... constructor ...||
  BeautyHomeTabPageNotifiers(this.context) {
    productsController = ProductsController.instance;
    sliderController = SliderController.instance;
    productsScrollController = ScrollController();
    productsScrollController.addListener(() {
      if (productsScrollController.position.pixels ==
          productsScrollController.position.maxScrollExtent) {
        if (!canLoadNewPage) return;
        page++;
        getServices();
      }
    });
  }

  // ||...................... logic methods ............................||

  // init
  void init(bool isInit) async {
  /*  try {*/
      try {
        if (!isInit) {
          isError = false;
          isSliderLoading = true;
          isProductsLoading = true;
        }
        coffeeSliderResponse =
            await sliderController.getSlider(Constants.SECTION_TYPE_COFFEE);
        productsResponse = await productsController.getProducts(
            AppShared
                .settingResponse.settings.serviceCategory[selectedCategory].id,
            page);
        isSliderLoading = false;
        isProductsLoading = false;
      } on DioError catch (e) {
        log(e.response.toString()) ;
        // TODO
      }
  /*  } catch (error) {
      isError = true;
      print(error.toString());
      Helpers.showMessage(
          AppShared.appLang['SomethingWentWrong'], MessageType.MESSAGE_FAILED);
    }*/
  }

  // get products by category id.
  void getServices() async {
    if (page == 1) {
      try {
        isProductsLoading = true;
        productsResponse = await productsController.getProducts(
            AppShared
                .settingResponse.settings.serviceCategory[selectedCategory].id,
            page);
        isProductsLoading = false;
      } catch (error) {
        isError = true;
        print(error.toString());
        Helpers.showMessage(AppShared.appLang['SomethingWentWrong'],
            MessageType.MESSAGE_FAILED);
      }
    } else {
      if (page > productsResponse.products.lastPage) return;
      isPagingLoading = true;
      ProductsResponse response = await productsController.getProducts(
          AppShared
              .settingResponse.settings.serviceCategory[selectedCategory].id,
          page);
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
