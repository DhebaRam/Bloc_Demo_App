// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../product_details_bloc/product_details_bloc.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   const ProductDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Product Details')),
//       body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
//         builder: (context, state) {
//           if (state is ProductDetailsSuccessState) {
//             final product = state.product;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${product.name}'),
//                   Text('Description: ${product.description}'),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Error loading product details'));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/product/product_bloc/product_bloc.dart';
import 'package:untitled/product/product_details_bloc/product_details_bloc.dart';
import 'package:untitled/product/product_details_bloc/product_details_state.dart';

import '../product_bloc/product_event.dart';
import '../product_details_bloc/product_details_event.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productID;

  const ProductDetailsScreen({super.key, required this.productID});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductDetailsBloc>().add(FetchSingleProduct(id: widget.productID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  const Text(
            'Product Details',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_rounded,
                color: Colors.black,
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(builder: (context, state) {
          if (state is FetchSingleProductSuccessState) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * .35,
                          padding: const EdgeInsets.only(bottom: 30),
                          width: double.infinity,
                          child: Image.network(
                            '${state.singleProduct.image}',
                            height: MediaQuery.of(context).size.height * 0.44,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator(
                                color: Colors.blue,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              );
                            },
                          )),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 40, right: 14, left: 14),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.singleProduct.category}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${state.singleProduct.title}',
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${state.singleProduct.price}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '${state.singleProduct.description}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                )
                              ])),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ],
                  )
                ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(
                Icons.add_shopping_cart,
                size: 30,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:  Text(
                      '+ Add to Cart',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
