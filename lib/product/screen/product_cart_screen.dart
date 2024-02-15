import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routers/app_routers.dart';
import '../models/cart_model.dart';
import '../product_cart_bloc/product_cart_bloc.dart';
import '../widget/cart_list_item.dart';

class ProductCartScreen extends StatefulWidget {
  const ProductCartScreen({super.key});

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCartBloc>().add(FetchProductInCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme:
              const IconThemeData(color: Colors.white //change your color here
                  ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF26CBE6),
              Color(0xFF26CBE0),
              Color(0xFF26CBD6),
              Color(0xFF26CBD0),
              Color(0xFF26CBC0),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          actions: const [
            // IconButton(
            //   icon: const Icon(Icons.add_shopping_cart,
            //       size: 26, weight: 0.01, color: Colors.white),
            //   onPressed: () {
            //
            //     // showBottomSheetWidget(context: context);
            //   },
            // ),
            SizedBox(width: 10)
          ],
          title: Text('Cart',
                  style: GoogleFonts.kanit().copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  textAlign: TextAlign.center)
              .animate(onPlay: (controller) => controller.repeat()),
          // .shimmer(duration: 120000.ms, color: const Color(0xFF80DDFF))
          // .animate() // this wraps the previous Animate in another Animate
          // .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
          // .slide(),
          centerTitle: true),
      body: BlocConsumer<ProductCartBloc, ProductCartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FetchProductInCartSuccessState) {
            return Column(children: [
              Expanded(
                  child: ListView.builder(
                itemCount: state.cartProductList.length,
                itemBuilder: (context, index) {
                  print(
                      'Cart Item ----> ${state.cartProductList[0].productId}');
                  CartProducts cartItem = state.cartProductList[index];
                  print('Cart Item ----> ${cartItem.productId}');
                  return Dismissible(
                    key: Key(cartItem.productId.toString()),
                    // Use a unique key for each item
                    background: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color(0xFF26CBE6),
                        Color(0xFF26CBE0),
                        Color(0xFF26CBD6),
                        Color(0xFF26CBD0),
                        Color(0xFF26CBC0),
                      ], begin: Alignment.topCenter, end: Alignment.center)),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      // Provider.of<CartProvider>(context,
                      //     listen: false)
                      //     .removeCartItem(index);
                    },
                    child: GestureDetector(
                        onTap: () {},
                        child: CartListItem(
                          cartItem: cartItem,
                          index: index,
                        )),
                  );
                },
              )),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF26CBE6),
                                      Color(0xFF26CBE0),
                                      Color(0xFF26CBD6),
                                      Color(0xFF26CBD0),
                                      Color(0xFF26CBC0),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight),
                                borderRadius: BorderRadius.circular(30)),
                            child: ElevatedButton(
                              onPressed: () {
                                // Provider.of<CartProvider>(context,
                                // listen: false)
                                //     .clearCart();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  // backgroundColor: Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              child: const Text(
                                "Clear Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Price:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Expanded(child: Container()),
                        Text(
                          '\$ 230',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF26CBE6),
                            Color(0xFF26CBE0),
                            Color(0xFF26CBD6),
                            Color(0xFF26CBD0),
                            Color(0xFF26CBC0),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                          borderRadius: BorderRadius.circular(255)),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.checkOutScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          // backgroundColor: Theme.of(context).colorScheme.primary,
                          elevation: 10,
                        ),
                        child: const Text('Checkout',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
