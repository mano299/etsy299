import 'package:etsy/features/card/cubit/card_cubit.dart';
import 'package:etsy/features/card/cubit/fakecard_cubit.dart';
import 'package:etsy/features/card/model/card_model.dart';
import 'package:etsy/features/home/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;
  int selectedIndex = 0;
  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fakeCubit = context.read<FakeCardCubit>();
    return Scaffold(
      //appBar: AppBar(
      //  backgroundColor: Color(0xff1c1a1f),
      // ),
      backgroundColor: Color(0xff1c1a1f),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 700,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: widget.productModel.images.length,
                        itemBuilder: (context, index) {
                          return GalleryImageView(listImage: [
                            NetworkImage(widget.productModel.images[index])
                          ]);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 16,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 16,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "In stock",
                      style: TextStyle(
                        color: Color(0xff9e93a3),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${widget.productModel.price}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.productModel.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text(
                          "by ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "MartinLasarty ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.purpleAccent, size: 16),
                        Text(
                          " Star Seller",
                          style: TextStyle(color: Colors.purpleAccent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Text(
                          "Ratings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "5.0",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Text(
                          " (1.3k)",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xff2b2830),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: DropdownButton<String>(
                        value: null,
                        hint: const Text(
                          "Quantity",
                          style: TextStyle(color: Colors.white70),
                        ),
                        dropdownColor: const Color(0xff2b2830),
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        items: const [
                          DropdownMenuItem(
                              value: "1",
                              child: Text("1",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: "2",
                              child: Text("2",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: "3",
                              child: Text("3",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: "4",
                              child: Text("4",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: "5",
                              child: Text("5",
                                  style: TextStyle(color: Colors.white))),
                        ],
                        onChanged: (val) {},
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          context.read<CardCubit>().addCardCubit(
                                productId: widget.productModel.id.toString(),
                              );

                          final cardItem = CardModel(
                            id: widget.productModel.id.toString(),
                            category: '',
                            name: widget.productModel.title,
                            price: widget.productModel.price,
                            image: widget.productModel.image,
                            company: '',
                            quantity: 1,
                            sales: 0,
                            totalPrice: widget.productModel.price,
                          );

                          context.read<FakeCardCubit>().addToFakeCart(cardItem);
                        },
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
