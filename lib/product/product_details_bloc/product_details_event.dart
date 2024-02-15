// part of 'product_details_bloc.dart';
//
// @immutable
// abstract class ProductDetailsEvent {}
//
// class SelectProductEvent extends ProductDetailsEvent {
//   final int productId;
//
//   SelectProductEvent({required this.productId});
//
//   List<Object> get props => [productId];
// }


abstract class ProductDetailsEvent {}
class FetchSingleProduct extends ProductDetailsEvent {
  final int id;
  FetchSingleProduct({required this.id});
}