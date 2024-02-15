// part of 'product_details_bloc.dart';
//
// @immutable
// abstract class ProductDetailsState {}
//
// class ProductDetailsInitial extends ProductDetailsState {}
//
//
// class ProductDetailsSuccessState extends ProductDetailsState {
//   final Product product;
//
//   ProductDetailsSuccessState({required this.product});
//
//   List<Object> get props => [product];
// }

import '../models/product_list_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class FetchProductLoaderState extends ProductDetailsState {}

class FetchSingleProductSuccessState extends ProductDetailsState {
  final ProductListModel singleProduct;

  FetchSingleProductSuccessState({required this.singleProduct});
}
class FetchProductErrorState extends ProductDetailsState {
  final String error;

  FetchProductErrorState({required this.error});
}