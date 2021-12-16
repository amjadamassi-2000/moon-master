import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moonapp/src/models/api_models/base_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/coffee_section_models/requests/add_to_cart_request.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/cart_resposne.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/favorite_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/product_details_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/products_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/reviews_response.dart';
import 'package:moonapp/src/models/api_models/customer_models/shared_models/similar_products_response.dart';
import 'package:moonapp/src/utils/app_shared.dart';
import 'package:moonapp/src/utils/constants.dart';


class ProductsController {
  static ProductsController _instance;

  // ||.. private constructor ..||
  ProductsController._();

  // ||.. singleton pattern ..||
  static ProductsController get instance {
    if (_instance != null) return _instance;
    return _instance = ProductsController._();
  }

//       ------------------ || .. usable  methods ..|| ----------------------

  // get products by category id
  Future<ProductsResponse> getProducts(int categoryId, int page) async {
    print('categoryId $categoryId') ;
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getProducts/$categoryId/${AppShared.sharedPreferencesController.getSectionType()}?page=$page',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );


    log('response.data.toString()') ;
    log(response.data.toString()) ;
    ProductsResponse productsResponse = ProductsResponse.fromJson(response.data);
    return productsResponse;
  }






  // get favorites products
  Future<FavoriteResponse> getFavoritesProducts(int page) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getMyFavorites/${AppShared.sharedPreferencesController.getSectionType()}?page=$page',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    log('getMyFavorites');
    log(response.data.toString());
    FavoriteResponse favoriteResponse = FavoriteResponse.fromJson(response.data);
    return favoriteResponse;
  }






  // get offers
  Future<ProductsResponse> getOffers({int page = 1}) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getOffers/${AppShared.sharedPreferencesController.getSectionType()}?page=$page',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );


   log(response.data.toString()) ;
    ProductsResponse productsResponse = ProductsResponse.fromJson(response.data, objName: 'productoffer');
    return productsResponse;
  }




  // get product details
  Future<ProductDetailsResponse> getProductDetails(
      {@required int productId}) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getProductById/$productId',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    ProductDetailsResponse productDetailsResponse =
        ProductDetailsResponse.fromJson(response.data);
    return productDetailsResponse;
  }



  // get cart
  Future<CartResponse> getCart() async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getMyCart/${AppShared.sharedPreferencesController.getSectionType()}',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    log(response.data.toString()) ;
    CartResponse cartResponse = CartResponse.fromJson(response.data);
    return cartResponse;
  }





  // add products to favorites
  Future<BaseResponse> addProductToFavorites(int productId) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}addToFavorite/$productId/${AppShared.sharedPreferencesController.getSectionType()}',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }

  // like a product
  Future<BaseResponse> likeAProduct(int productId) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}like/$productId',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );

    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }

  // search about product
  Future<ProductsResponse> searchAboutProduct(String text, int page) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}search?text=$text&type=${AppShared.sharedPreferencesController.getSectionType()}&page=$page',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    ProductsResponse productsResponse =
        ProductsResponse.fromJson(response.data);
    return productsResponse;
  }

  // add product to cart
  Future<BaseResponse> addProductToCart({
    @required int productId,
    int sizeId,
    @required int quantity,
  }) async {
    AddToCartRequest addToCartRequest = AddToCartRequest(
      productId: productId,
      quantity: quantity,
      sizeId: sizeId,
      type: AppShared.sharedPreferencesController.getSectionType(),
    );
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}addProductToCart',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: addToCartRequest.toJson(),
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }



  //change quantity
  Future<BaseResponse> changeQuantity({
    @required int productId,
    @required int type,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}changeQuantity',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: {
        'product_id': productId,
        'type': type,
      },
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }









  //add addition to cart product.
  Future<BaseResponse> addAddition({
    @required int cartId,
    @required int additionId,
    @required int quantity,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}addAdditionTocart',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: {
        'cart_id': cartId,
        'addition_id': additionId,
        'quantity': quantity,
      },
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }

  // remove  product from cart.
  Future<BaseResponse> removeProductFromCart(int cartId) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}deleteProductCart/$cartId',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }

  // get product reviews .
  Future<ReviewsResponse> getProductReviews({
    @required int productId,
    int page = 1,
  }) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getProductReviews/$productId?page=$page',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    ReviewsResponse reviewsResponse = ReviewsResponse.fromJson(response.data);
    return reviewsResponse;
  }

  //rate product
  Future<BaseResponse> rateProduct({
    @required int productId,
    @required num rate,
    @required String comment,
  }) async {
    Response response = await AppShared.dio.post(
      '${Constants.API_BASE_URL}productReview',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
      data: {
        'product_id': productId,
        'rate': rate,
        'comment': comment,
      },
    );
    BaseResponse baseResponse = BaseResponse.fromJson(response.data);
    return baseResponse;
  }

  // get similar products.
  Future<SimilarProductsResponse> getSimilarProducts(int productId) async {
    Response response = await AppShared.dio.get(
      '${Constants.API_BASE_URL}getSimllerProducts/$productId',
      options: Options(
        headers: {
          'Authorization': AppShared.sharedPreferencesController.getIsLogin()
              ? 'Bearer ${AppShared.currentUser.accessToken}'
              : null,
          'fcmToken': AppShared.firebaseToken,
          'Accept-Language': AppShared.sharedPreferencesController.getAppLang(),
        },
      ),
    );
    SimilarProductsResponse similarProductsResponse =
        SimilarProductsResponse.fromJson(response.data);
    return similarProductsResponse;
  }
}
