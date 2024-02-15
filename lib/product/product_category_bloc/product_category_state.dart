part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryState {}

class ProductCategoryInitial extends ProductCategoryState {}

class FetchProductCategoryLoader extends ProductCategoryState{}
class FetchProductCategorySuccess extends ProductCategoryState{
  final List<ProductCategoryModel> productCategory;

  FetchProductCategorySuccess({required this.productCategory});
}
class FetchProductFailedLoader extends ProductCategoryState{
  final String error;

  FetchProductFailedLoader({required this.error});
}