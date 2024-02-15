import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/product/models/cart_model.dart';

import '../reps/product_repo.dart';

part 'product_cart_event.dart';

part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc() : super(ProductCartInitial()) {
    on<FetchProductInCartEvent>(_fetchProductCart);
    on<AddProductCartEvent>(_addProductInCart);
  }

  Future<FutureOr<void>> _fetchProductCart(
      FetchProductInCartEvent event, Emitter<ProductCartState> emit) async {
    try {
      List<CartProducts> productCartList = [];
      //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      //   sharedPreferences.getString('UserId');
      //   var map = <String, dynamic>{};
      //   map['username'] = event.userName;
      //   map['password'] = event.password;
      emit(FetchProductInCartLoaderState());
      final response = await ProductRepos().fetchProductInCart();
      log('cartResponse----> ${response.data}');
      List cartResponse = response.data['products'];
      log('cartResponse----> ${cartResponse.toString()}');
      cartResponse.map((e) {
        print('productCartList ----> ${e}');
        productCartList.add(CartProducts.fromJson(e));
      }).toList();

      emit(FetchProductInCartSuccessState(cartProductList: productCartList));
    } catch (e) {
      emit(FetchProductInCartErrorState(error: e.toString()));
      log(e.toString());
    }
  }

  Future<FutureOr<void>> _addProductInCart(
      AddProductCartEvent event, Emitter<ProductCartState> emit) async {
    try {
      var map = <String, dynamic>{};
      map['userId'] = '2';
      map['date'] = '2020-02-03';
      map['products'] = [
        {"productId": "2", "quantity": "1"},
        {"productId": "1", "quantity": "5"}
      ];
      emit(AddProductInCartLoaderState());
      final response = await ProductRepos().addProductInCart(map);
      emit(AddProductInCartSuccessState());
    } catch (e) {
      emit(AddProductInCartErrorState());
      log(e.toString());
    }
  }
}
