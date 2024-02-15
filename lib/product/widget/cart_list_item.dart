import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class CartListItem extends StatefulWidget {
  final CartProducts cartItem;
  final int index;

  const CartListItem({super.key, required this.cartItem, required this.index});

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  String currency = "₦";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl:
                  'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
              fit: BoxFit.cover,
              width: 67,
              height: 100,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rain Jacket Women',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "\$ 39.50",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF26CBE6),
                                    Color(0xFF26CBE0),
                                    Color(0xFF26CBD6),
                                    Color(0xFF26CBD0),
                                    Color(0xFF26CBC0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.center),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.white,
                              iconSize: 16,
                              onPressed: () {
                                // Provider.of<CartProvider>(context,
                                //     listen: false)
                                //     .increaseCartItemQuantity(widget.index);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.cartItem.quantity.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF26CBE6),
                                    Color(0xFF26CBE0),
                                    Color(0xFF26CBD6),
                                    Color(0xFF26CBD0),
                                    Color(0xFF26CBC0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.center),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              color: Colors.white,
                              iconSize: 16,
                              onPressed: () {
                                // if (quantity >= 1) {
                                //   Provider.of<CartProvider>(context,
                                //       listen: false)
                                //       .decreaseCartItemQuantity(widget.index);
                                // }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
