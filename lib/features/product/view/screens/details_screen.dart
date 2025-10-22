import 'package:etsy/features/home/data/model.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      //appBar: AppBar(
      //  backgroundColor: Color(0xff1c1a1f),
      // ),
      backgroundColor: Color(0xff1c1a1f),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: 450,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: Image.network(
                      "https://e7.pngegg.com/pngimages/739/735/png-clipart-t-shirt-clothing-sleeve-polo-shirt-creative-t-shirt-design-thumbnail.png",
                      fit: BoxFit.contain,
                    )),
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
                      child: const Icon(Icons.arrow_back, color: Colors.white),
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
                  const Text(
                    "\$8.39",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Vintage Style Green Ceramic Door / Cabinet / Drawer Knobs Handles - 12 Varieties - Sold Individually",
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
                        "Maylouiseinteriors ",
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
                        "Ratings ",
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
                        " (1.2k)",
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
                      onPressed: () {},
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
    );
  }
}
