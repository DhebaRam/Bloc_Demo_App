part of 'product_filter_bloc.dart';

@immutable
abstract class ProductFilterEvent {}

class ProductFilterDesEvent extends ProductFilterEvent {
  final bool productFilterApplied;
  ProductFilterDesEvent({required this.productFilterApplied});
}
