// import 'package:bloc/bloc.dart';
// import 'package:untitled/product/product_bloc/product_event.dart';
// import 'package:untitled/product/product_bloc/product_state.dart';
//
// import '../models/product_list_model.dart';
//
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final List<Product> _products = [
//     Product(id: 1, name: 'Product 1', description: 'Description 1'),
//     Product(id: 2, name: 'Product 2', description: 'Description 2'),
//     // Add more products
//   ];
//
//   ProductBloc() : super(ProductLoadingState()) {
//     on<LoadProductsEvent>(mapEventToState);
//   }
//
//   mapEventToState(ProductEvent event, Emitter<ProductState> emit) {
//     if (event is LoadProductsEvent) {
//       emit(ProductLoadedState(products: _products));
//     }
//   }
// }

import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled/product/product_bloc/product_event.dart';

import '../../mongo_db/dbHelper/mongo_db_connect.dart';
import '../models/product_list_model.dart';
import '../reps/product_repo.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>(_fetchProduct);
    on<FetchProductEvent>(_fetchProductInDatabase);
    // on<FetchSingleProduct>(_getSingleProduct);
    // on<ProductDetailsNavigatorEvent>(_navigatorSingleProductPage);
  }

  FutureOr<void> _fetchProduct(FetchProduct event, Emitter<ProductState> emit) async{
    try {
      List<ProductListModel> productList = [];
      emit(FetchProductLoader());
      final response = await ProductRepos().fetchProduct(productCategory: event.productCategory, productSort: event.sort);
      List productResponse = response.data;
      log(productResponse.length.toString());
      productResponse.map((e) => productList.add(ProductListModel.fromJson(e))).toList();
      emit(FetchProductSuccess(productList: productList));
    }catch(e){
      emit(FetchProductError(error: e.toString()));
      log(e.toString());
    }
  }

  FutureOr<void> _fetchProductInDatabase(FetchProductEvent event, Emitter<ProductState> emit)async {
    try{
      emit(FetchProductLoaderState());
      List<ProductModel> data = [];
      var result = await MongodbDataBase.fetchProduct();
      print('Result ----- > ${result.isEmpty}');
      print('Result ----- > ${result.length}');
      if(result['status'] == true){
        result['data'].map((event) {
          print('Evemt ---- ${event}');
          print('Evemt ---- ${event['image'].runtimeType}');
          data.add(ProductModel.fromJson(event));
        }).toList();
        emit(FetchProductSuccessState(productList: data));
      }else{
        emit(FetchProductErrorState(error: result['message']));
      }
    }
    catch(e){
      log('_fetchProductInDatabase ${e.toString()}');
      emit(FetchProductErrorState(error: e.toString()));
    }
  }

  // FutureOr<void> _getSingleProduct(FetchSingleProduct event, Emitter<ProductState> emit) async{
  //   try {
  //     ProductListModel singleProduct = ProductListModel();
  //     emit(FetchProductLoader());
  //     final response = await ProductRepos().fetchSingleProduct(event.id.toString());
  //     singleProduct = ProductListModel.fromJson(response.data);
  //     emit(FetchSingleProductSuccess(singleProduct: singleProduct));
  //   }catch(e){
  //     emit(FetchProductError(error: e.toString()));
  //     log(e.toString());
  //   }
  // }

  // FutureOr<void> _navigatorSingleProductPage(ProductDetailsNavigatorEvent event, Emitter<ProductState> emit) {
  //   emit(ProductDetailsNavigatorState(id: event.id));
  // }
}
