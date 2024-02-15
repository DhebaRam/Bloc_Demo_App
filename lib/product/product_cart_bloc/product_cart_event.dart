part of 'product_cart_bloc.dart';

@immutable
abstract class ProductCartEvent {}

class AddProductCartEvent extends ProductCartEvent {}
class FetchProductInCartEvent extends ProductCartEvent {}