import 'dart:developer';
import 'package:untitled/api_manager/api_model.dart';
import '../../api_manager/api_manager.dart';

class ProductRepos {
  APIManager apiManager = APIManager();

  Future<ApiResponseModel> fetchProduct({String? productCategory, productSort}) async {
    String endPoint = 'https://fakestoreapi.com/products';
    String url;
    if(productCategory != 'All'){
      url = '$endPoint/category/$productCategory';
    }else{
      url = endPoint;
    }
    if(productSort != null && productSort != ''){
      url = '$url?sort=$productSort';
    }
    final response = await apiManager.request(url, Method.get, {});
    log('API Response Fetch Product ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> fetchUserProfileData({String? productCategory, productSort}) async {
    String endPoint = 'https://fakestoreapi.com/users/2';

    final response = await apiManager.request(endPoint, Method.get, {});
    log('API Response Fetch Product ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> fetchSingleProduct(String id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await apiManager.request(url, Method.get, {});
    log('API Response in Repo File ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> fetchProductCategory() async {
    const url = 'https://fakestoreapi.com/products/categories';
    final response = await apiManager.request(url, Method.get, {});
    log('API Response in Repo File ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> addProductInCart(Map<String, dynamic> map) async {
    const url = 'https://fakestoreapi.com/carts';
    final response = await apiManager.request(url, Method.post, map);
    log('API Response addProductInCart ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response Error addProductInCart ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }

  Future<ApiResponseModel> fetchProductInCart() async {
    const String url = 'https://fakestoreapi.com/carts/2';
    final response = await apiManager.request(url, Method.get, {});
    log('API Response in Repo File Fetch Cart ---- > ${response.data}');
    if (response.status) {
      return response;
    } else {
      log('API Response in Repo File ---- > ${response.data}');
      throw response.error?.title ?? 'Something went wrong! Please try again';
    }
  }
}
