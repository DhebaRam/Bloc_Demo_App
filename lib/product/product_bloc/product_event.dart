// import 'package:equatable/equatable.dart';
//
// abstract class ProductEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }
//



import 'package:flutter/foundation.dart';

class LoadProductsEvent extends ProductEvent {}

@immutable
abstract class ProductEvent {}

class FetchProduct extends ProductEvent {
  final String productCategory;
  final String? sort;
  FetchProduct({required this.productCategory, this.sort});
}
class FetchProductCategory extends ProductEvent {}

class FetchProductDescOrder extends ProductEvent{}

class FetchProductEvent extends ProductEvent{}

// class FetchSingleProduct extends ProductEvent {
//   final int id;
//   FetchSingleProduct({required this.id});
// }