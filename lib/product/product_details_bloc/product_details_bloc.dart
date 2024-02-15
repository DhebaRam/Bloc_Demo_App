// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
//
// import '../models/product_list_model.dart';
//
// part 'product_details_event.dart';
//
// part 'product_details_state.dart';
//
// class ProductDetailsBloc
//     extends Bloc<ProductDetailsEvent, ProductDetailsState> {
//   final List<Product> _products = [
//     Product(id: 1, name: 'Product 1', description: 'Description 1'),
//     Product(id: 2, name: 'Product 2', description: 'Description 2'),
//     // Add more products
//   ];
//
//   ProductDetailsBloc() : super(ProductDetailsInitial()) {
//     on<SelectProductEvent>(mapEventToState);
//   }
//
//   mapEventToState(SelectProductEvent event, Emitter<ProductDetailsState> emit) {
//     final selectedProduct =
//         _products.firstWhere((product) => product.id == event.productId);
//     emit(ProductDetailsSuccessState(product: selectedProduct));
//   }
// }

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:untitled/product/product_details_bloc/product_details_event.dart';
import 'package:untitled/product/product_details_bloc/product_details_state.dart';

import '../models/product_list_model.dart';
import '../reps/product_repo.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<FetchSingleProduct>(_getSingleProduct);
  }

  Future<void> _getSingleProduct(
      FetchSingleProduct event, Emitter<ProductDetailsState> emit) async {
    try {
      ProductListModel singleProduct = ProductListModel();
      emit(FetchProductLoaderState());
      final response =
          await ProductRepos().fetchSingleProduct(event.id.toString());
      singleProduct = ProductListModel.fromJson(response.data);
      emit(FetchSingleProductSuccessState(singleProduct: singleProduct));
    } catch (e) {
      emit(FetchProductErrorState(error: e.toString()));
      log(e.toString());
    }
  }
}
