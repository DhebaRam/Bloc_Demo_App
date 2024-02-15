// // product_listing_screen.dart
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../product_bloc/product_bloc.dart';
// import '../product_bloc/product_event.dart';
// import '../product_bloc/product_state.dart';
// import '../product_details_bloc/product_details_bloc.dart';
// // import 'product_bloc.dart';
//
// class ProductListingScreen extends StatefulWidget {
//   const ProductListingScreen({super.key});
//
//   @override
//   State<ProductListingScreen> createState() => _ProductListingScreenState();
// }
//
// class _ProductListingScreenState extends State<ProductListingScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     log('LoadProductsEvent Calling');
//     context.read<ProductBloc>().add(LoadProductsEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Product Listing')),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           log('Current State ----> $state');
//
//           if (state is ProductLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoadedState) {
//             return ListView.builder(
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text(product.description),
//                   onTap: () {
//                     context.read<ProductDetailsBloc>().add(SelectProductEvent(productId: product.id));
//                     Navigator.pushNamed(context, '/productDetails');
//                   },
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('Error loading products'));
//           }
//         },
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/product/models/product_list_model.dart';
import 'package:untitled/product/product_bloc/product_bloc.dart';
import 'package:untitled/product/product_filter_bloc/product_filter_bloc.dart';
import 'package:untitled/product/screen/product_details_screen.dart';
import 'package:untitled/utis/extentions.dart';

import '../../package/add_to_cart_icon/add_to_cart_animation.dart';
import '../../routers/app_routers.dart';
import '../../utis/app_theme.dart';
import '../../utis/color_config.dart';
import '../product_bloc/product_event.dart';
import '../product_cart_bloc/product_cart_bloc.dart';
import '../product_category_bloc/product_category_bloc.dart';
import '../widget/product_icon.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  ProductBloc productBloc = ProductBloc();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;
  String selectCategory = 'All';
  bool currentFilter = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
        // To send the library the location of the Cart icon
        cartKey: cartKey,
        height: 30,
        width: 30,
        opacity: 0.85,
        dragAnimation: const DragToCartAnimationOptions(
          rotation: true,
        ),
        jumpAnimation: const JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
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
              actions: [
                // IconButton(
                //   key: cartKey,
                //   icon: const Icon(Icons.add_shopping_cart,
                //       size: 26, weight: 0.01, color: Colors.white),
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => const ProductCartScreen()));
                //     // showBottomSheetWidget(context: context);
                //   },
                // ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.productCartScreen);
                    },
                    child: AddToCartIcon(
                      key: cartKey,
                      icon: const Icon(Icons.add_shopping_cart,
                          size: 26, weight: 0.01, color: Colors.white),
                      badgeOptions: const BadgeOptions(
                        active: true,
                        backgroundColor: Colors.white,
                      ),
                    )),
                const SizedBox(width: 10)
              ],
              title: Text('Product List',
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
          body: Column(
            children: [
              // Flexible(flex: 1, child: productCategoryWidget()),
              Expanded(flex: 10, child: productListWidget())
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<ProductBloc>().add(FetchProductEvent());
              // context
              //     .read<ProductBloc>()
              //     .add(FetchProduct(productCategory: 'All'));
              // Navigator.of(context).pushNamed(AppRoutes.addNewProductScreen);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  void listClick(GlobalKey widgetKey) async {
    context.read<ProductCartBloc>().add(AddProductCartEvent());
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  Future showBottomSheetWidget({required BuildContext context}) {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: const Center(
                  child: Text("This is a modal sheet"),
                )),
          );
        });
  }

  Widget productListWidget() {
    return BlocConsumer<ProductBloc, ProductState>(
      // bloc: productBloc,
      // listenWhen: (previous, current) => current is FetchProductSuccess,
      // buildWhen: (previous, current) => current is! FetchProductSuccess,
      builder: (context, state) {
        log('Current Active Event ----> $state');
        if (state is FetchProductErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is FetchProductSuccessState) {
          return GridView.builder(
            itemCount: state.productList.length,
            itemBuilder: (context, index) => ProductTile(
              onClick: listClick,
              product: state.productList[index],
              index: index,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10.0),
          );
        }
        if (state is FetchProductLoaderState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox.shrink();
      },
      listener: (BuildContext context, ProductState state) {},
    );
  }

  Widget productCategoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      width: MediaQuery.of(context).size.width,
      // color: Colors.cyan,
      height: 80,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        BlocConsumer<ProductCategoryBloc, ProductCategoryState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FetchProductCategorySuccess) {
              return Expanded(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.productCategory
                    .map(
                      (category) => ProductIcon(
                        model: category,
                        onSelected: (model) {
                          selectCategory = model.name;
                          context
                              .read<ProductBloc>()
                              .add(FetchProduct(productCategory: model.name));
                          setState(() {
                            for (var item in state.productCategory) {
                              item.isSelected = false;
                            }
                            model.isSelected = true;
                          });
                        },
                      ),
                    )
                    .toList(),
              ));
            }
            return const SizedBox.shrink();
          },
        ),
        BlocConsumer<ProductFilterBloc, ProductFilterState>(
          listener: (context, state) {
            if (state is ProductFilterAppliedState) {
              currentFilter = state.productFilterApplied;
              // if(currentFilter == true){
              context.read<ProductBloc>().add(
                  FetchProduct(productCategory: selectCategory, sort: 'desc'));
              // }
            }
            if (state is ProductFilterRemoveState) {
              currentFilter = state.productFilterApplied;
              context
                  .read<ProductBloc>()
                  .add(FetchProduct(productCategory: selectCategory, sort: ''));
            }
            // {
            //   print('Product State --- > ${currentFilter}');
            //   context.read<ProductBloc>().add(FetchProduct(productCategory: selectCategory, sort: ''));
            // }
          },
          builder: (context, state) {
            if (state is ProductFilterAppliedState) {
              return filterWidget(isApplied: state.productFilterApplied);
            }
            return filterWidget(isApplied: false);
          },
        )
      ]),
    );
  }

  void onFilterClick() {
    log('onFilterClick ---- > ${!currentFilter}');
    context
        .read<ProductFilterBloc>()
        .add(ProductFilterDesEvent(productFilterApplied: !currentFilter));
  }

  Widget filterWidget({bool isApplied = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.transparent,
                border: Border.all(
                  color: isApplied ? Colors.cyan : grey,
                  width: 1,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Icon(Icons.filter_list,
                  color: isApplied ? Colors.cyan : null))
          .ripple(
        () {
          onFilterClick();
        },
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey) onClick;
  final ProductModel product;

  ProductTile({
    super.key,
    required this.index,
    required this.onClick,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    print('Trypw---- >  ${product.image.runtimeType}');
    List<int> intlist = product.image!.cast<int>().toList(); //this is the magical line.
    Uint8List data = Uint8List.fromList(intlist);
    // Uint8List imageBytes = product.image?.cast<Uint8List>() as Uint8List;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    productID: product.id,
                  )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: AppTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x3600000F),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Container(
                            key: widgetKey,
                            child: product.imageUrl != null
                                ? Image.network(product.imageUrl.toString(),
                                width: 100, height: 100, fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CircularProgressIndicator(
                                        color: Colors.blue,
                                        value: loadingProgress.expectedTotalBytes !=
                                            null
                                            ? loadingProgress
                                            .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ));
                                })
                                : Image.memory(
                              data,
                              // width: 100,
                              // height: 100,
                              fit: BoxFit.fitWidth,
                              errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                                return const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                      // value: loadingProgress.expectedTotalBytes !=
                                      //     null
                                      //     ? loadingProgress
                                      //     .cumulativeBytesLoaded /
                                      //     loadingProgress.expectedTotalBytes!
                                      //     : null,
                                    ));
                              },
                            )
                            // Image.network(product.image.toString(),
                            //     width: 100, height: 100, fit: BoxFit.fill,
                            //     loadingBuilder: (BuildContext context,
                            //         Widget child,
                            //         ImageChunkEvent? loadingProgress) {
                            //       if (loadingProgress == null) return child;
                            //       return Padding(
                            //           padding: const EdgeInsets.all(5),
                            //           child: CircularProgressIndicator(
                            //             color: Colors.blue,
                            //             value: loadingProgress.expectedTotalBytes !=
                            //                 null
                            //                 ? loadingProgress
                            //                 .cumulativeBytesLoaded /
                            //                 loadingProgress.expectedTotalBytes!
                            //                 : null,
                            //           ));
                            //     })
                            )
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                  child: Text(
                    product.title ?? '',
                    maxLines: 1,
                    style: AppTheme.of(context).bodyText1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                      child: Text(
                        '\$${product.price}',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.of(context).bodyText2,
                      ),
                    ),
                    IconButton(
                        onPressed: () => onClick(widgetKey),
                        splashColor: Colors.cyan,
                        icon: const Icon(Icons.add_shopping_cart_rounded))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
