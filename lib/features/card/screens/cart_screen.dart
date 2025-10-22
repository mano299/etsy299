import 'package:etsy/features/card/cubit/unifiedcard_cubit.dart';
import 'package:etsy/features/card/cubit/unifiedcard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E1E2A),
        elevation: 0,
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UnifiedCartCubit, UnifiedCartState>(
        builder: (context, state) {
          if (state is UnifiedCartLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent));
          } else if (state is UnifiedCartLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent));
            }

            num subtotal = 0;
            for (final item in items) {
              subtotal += item.item.totalPrice;
            }

            const shipping = 11.89;
            final total = subtotal + shipping;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final product = items[index].item;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A3C),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header (shop name)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.store,
                                            color: Colors.black, size: 18),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        product.company,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "(Shop policies)",
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 13),
                                  )
                                ],
                              ),
                            ),

                            // Product info
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product.category,
                                          style: const TextStyle(
                                              color: Colors.white60,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "\$${product.price}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close,
                                        color: Colors.white70),
                                    onPressed: () {
                                      context
                                          .read<UnifiedCartCubit>()
                                          .removeUnifiedItem(items[index]);
                                    },
                                  )
                                ],
                              ),
                            ),

                            // Quantity controls
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white24, width: 1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove,
                                              color: Colors.white),
                                          onPressed: () {
                                            context
                                                .read<UnifiedCartCubit>()
                                                .decreaseUnifiedQuantity(
                                                    items[index]);
                                          },
                                        ),
                                        Text(
                                          "${product.quantity}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add,
                                              color: Colors.white),
                                          onPressed: () {
                                            context
                                                .read<UnifiedCartCubit>()
                                                .increaseUnifiedQuantity(
                                                    items[index]);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Bottom total
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Color(0xff2A2A3C),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      _buildPriceRow("Subtotal", subtotal),
                      _buildPriceRow("Shipping", shipping),
                      const Divider(color: Colors.white24),
                      _buildPriceRow("Estimated total", total,
                          bold: true, color: Colors.white),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Proceed to checkout",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("Error loading cart"));
        },
      ),
    );
  }

  Widget _buildPriceRow(String label, num value,
      {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                color: color ?? Colors.white70,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: color ?? Colors.white70,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
