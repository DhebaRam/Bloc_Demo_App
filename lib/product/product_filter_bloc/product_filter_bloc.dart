import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_filter_event.dart';

part 'product_filter_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductFilterBloc() : super(ProductFilterInitial()) {
    on<ProductFilterDesEvent>(_productFilterClick);
  }

  FutureOr<void> _productFilterClick(
      ProductFilterDesEvent event, Emitter<ProductFilterState> emit) {
    log('_productFilterClick Method Calling -----> ${event.productFilterApplied}');
    if(event.productFilterApplied){
      emit(ProductFilterAppliedState(productFilterApplied: event.productFilterApplied));
    }else {
      emit(ProductFilterRemoveState(
          productFilterApplied: event.productFilterApplied));
    }
  }
}
