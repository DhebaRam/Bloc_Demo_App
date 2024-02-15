import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/product_category.dart';
import '../reps/product_repo.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc() : super(ProductCategoryInitial()) {
    on<FetchProductCategoryEvent>(_fetchProductCategory);
  }

  FutureOr<void> _fetchProductCategory(FetchProductCategoryEvent event, Emitter<ProductCategoryState> emit) async{
    try {
      List<ProductCategoryModel> productCategoryList = [
        ProductCategoryModel.fromJson('All', true)
      ];

      emit(FetchProductCategoryLoader());
      final response = await ProductRepos().fetchProductCategory();
      log("productResponse response -----> ${response.toString()}");
      List productResponse = response.data;
      productResponse.map((e) => productCategoryList.add(ProductCategoryModel.fromJson(e, false))).toList();
      emit(FetchProductCategorySuccess(productCategory: productCategoryList));
    }catch(e){
      emit(FetchProductFailedLoader(error: e.toString()));
      log(e.toString());
    }
  }
}
