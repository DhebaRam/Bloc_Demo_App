part of 'product_cart_bloc.dart';

@immutable
abstract class ProductCartState {}

class ProductCartInitial extends ProductCartState {}
class FetchProductInCartLoaderState extends ProductCartState {}
class FetchProductInCartSuccessState extends ProductCartState {
  final List<CartProducts> cartProductList;
  FetchProductInCartSuccessState({required this.cartProductList});
}
class FetchProductInCartErrorState extends ProductCartState {
  final String error;
  FetchProductInCartErrorState({required this.error});
}

class AddProductInCartLoaderState extends ProductCartState {}
class AddProductInCartSuccessState extends ProductCartState {
  // final List<CartProducts> cartProductList;
  // FetchProductInCartSuccessState({required this.cartProductList});
}
class AddProductInCartErrorState extends ProductCartState {
  // final String error;
  // FetchProductInCartErrorState({required this.error});
}
