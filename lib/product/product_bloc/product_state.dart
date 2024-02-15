// import 'package:equatable/equatable.dart';
//
// import '../models/product_list_model.dart';
//
// abstract class ProductState extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//
// class ProductLoadingState extends ProductState {}
//
// class ProductLoadedState extends ProductState {
//   final List<Product> products;
//
//   ProductLoadedState({required this.products});
//
//   @override
//   List<Object> get props => [products];
// }







part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class FetchProductLoader extends ProductState {}

class FetchProductError extends ProductState {
  final String error;

  FetchProductError({required this.error});
}

class FetchProductSuccess extends ProductState {
  final List<ProductListModel> productList;

  FetchProductSuccess({required this.productList});
}


class FetchProductLoaderState extends ProductState {}

class FetchProductErrorState extends ProductState {
  final String error;

  FetchProductErrorState({required this.error});
}

class FetchProductSuccessState extends ProductState {
  final List<ProductModel> productList;

  FetchProductSuccessState({required this.productList});
}


// class ProductAction extends ProductState {}
//
// class FetchSingleProductSuccess extends ProductState {
//   final ProductListModel singleProduct;
//
//   FetchSingleProductSuccess({required this.singleProduct});
// }
//
// class ProductDetailsNavigatorState extends ProductAction {
//   final int id;
//
//   ProductDetailsNavigatorState({required this.id});
// }
