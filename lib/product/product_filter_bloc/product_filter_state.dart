part of 'product_filter_bloc.dart';

@immutable
abstract class ProductFilterState {}

class ProductFilterInitial extends ProductFilterState {}

class ProductFilterAppliedState extends ProductFilterState {
  final bool productFilterApplied;

  ProductFilterAppliedState({required this.productFilterApplied});
}

class ProductFilterRemoveState extends ProductFilterState {
  final bool productFilterApplied;

  ProductFilterRemoveState({required this.productFilterApplied});
}
