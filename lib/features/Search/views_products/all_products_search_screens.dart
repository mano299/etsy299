import 'package:etsy/features/Search/Electronics/cubit/electronics_cubit.dart';
import 'package:etsy/features/Search/Electronics/data/model_products.dart';
import 'package:etsy/features/Search/T_shirts/cubit/tshirt_cubit.dart';
import 'package:etsy/features/Search/T_shirts/data/model_t_shirts.dart';
import 'package:etsy/features/Search/products/cubit/product_cubit.dart';
import 'package:etsy/features/Search/products/model/product_model.dart';
import 'package:etsy/features/Search/views_products/electronics.dart';
import 'package:etsy/features/Search/views_products/laptops.dart';
import 'package:etsy/features/Search/views_products/t_shirts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';

class AllProductsSearchScreens extends StatefulWidget {
  const AllProductsSearchScreens({super.key});

  @override
  State<AllProductsSearchScreens> createState() =>
      _AllProductsSearchScreensState();
}

class _AllProductsSearchScreensState extends State<AllProductsSearchScreens> {
  final List<String> namesCategory = [
    "Lapetops",
    "Computers ",
    "Electronics",
    "Cameras",
    "T-Shirts",
    "Bages",
  ];
  final List<String> imagesAssetsCategory = [
    "assets/images/laptops.png",
    "assets/images/computers_peripherals.png",
    "assets/images/electronics.png",
    "assets/images/cameras.png",
    "assets/images/t_shirts.png",
    "assets/images/bages.png",
  ];
  final List<String> products = [
    'T-Shirt',
    'Meal',
    'Laptop',
    'Headphones',
    'Shoes',
  ];
  late ElectronicsCubit electronicsCubit;
  late ProductCubit laptopCubit;
  late TshirtCubit tshirtCubit;

  List allItems = [];

  @override
  void initState() {
    super.initState();
    electronicsCubit = ElectronicsCubit()..getDataCubit();
    laptopCubit = ProductCubit()..getDataCubit();
    tshirtCubit = TshirtCubit()..getDataCubit();
  }

  void updateAllItems() {
    final electronicsState = electronicsCubit.state;
    final laptopState = laptopCubit.state;
    final tshirtState = tshirtCubit.state;

    List<dynamic> combined = [];

    if (electronicsState is ElectronicsSuccessState) {
      combined.addAll(electronicsState.model);
    }
    if (laptopState is ProductSuccessState) {
      combined.addAll(laptopState.model);
    }
    if (tshirtState is TshirtSuccessState) {
      combined.addAll(tshirtState.model);
    }

    setState(() => allItems = combined);
  }

  void openSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchPage<dynamic>(
        barTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        items: allItems,
        searchLabel: 'Search product',
        suggestion: const Center(
          child: Text(
            'Search by name',
            style: TextStyle(color: Colors.white),
          ),
        ),
        failure: const Center(
          child: Text(
            'No item found',
            style: TextStyle(color: Colors.white),
          ),
        ),
        filter: (item) {
          try {
            if (item.name != null) return [item.name.toString()];
            if (item.title != null) return [item.title.toString()];
          } catch (e) {
            return [];
          }
          return [];
        },
        builder: (item) => ListTile(
          title: Text(
            item.name ?? item.title ?? 'No Name',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  if (item is ModelProducts) {
                    return Electronics(model: item);
                    //ElectronicsDetailsScreen(model: item);
                  } else if (item is ProductModel) {
                    return Laptops(model: item);
                    // LaptopDetailsScreen(model: item);
                  } else if (item is ModelTShirts) {
                    return TShirts(model: item);
                    // TshirtDetailsScreen(model: item);
                  } else {
                    return Scaffold(
                      body: Center(
                          child: Text(
                        'No details available',
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => electronicsCubit),
        BlocProvider(create: (context) => laptopCubit),
        BlocProvider(create: (context) => tshirtCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ElectronicsCubit, ElectronicsState>(
            listener: (context, state) => updateAllItems(),
          ),
          BlocListener<ProductCubit, ProductState>(
            listener: (context, state) => updateAllItems(),
          ),
          BlocListener<TshirtCubit, TshirtState>(
            listener: (context, state) => updateAllItems(),
          ),
        ],
        child: Scaffold(
          backgroundColor: Color(0xFF1b181f),
          appBar: AppBar(
            backgroundColor: const Color(0xFF312b35),
            title: InkWell(
              onTap: () => openSearch(context),
              child: const Text(
                "Search for something special",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 34),
              onPressed: () => openSearch(context),
            ),
            actions: const [
              Icon(Icons.camera_alt, color: Colors.white, size: 34),
              SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shop by category",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => Card(
                      color: Color(0xFF312b35),
                      elevation: 3,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.asset(
                              imagesAssetsCategory[index],
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                namesCategory[index],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<TshirtCubit, TshirtState>(
                  builder: (context, state) {
                    if (state is TshirtLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is TshirtSuccessState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "T-Shirts",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            backgroundColor: Color(0xFF1b181f),
                                            appBar: AppBar(
                                              backgroundColor:
                                                  Color(0xFF312b35),
                                              iconTheme: IconThemeData(
                                                  color: Colors.white),
                                              title: Text(
                                                "T-Shirts",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              centerTitle: true,
                                            ),
                                            body: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2.7 / 4,
                                              ),
                                              itemCount: state.model.length,
                                              itemBuilder: (context, index) =>
                                                  TShirts(
                                                model: state.model[index],
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Explore more",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (context, index) => SizedBox(
                                width: 200,
                                child: TShirts(
                                  model: state.model[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 25),
                BlocBuilder<ElectronicsCubit, ElectronicsState>(
                  builder: (context, state) {
                    if (state is ElectronicsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ElectronicsSuccessState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Electronics",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            backgroundColor: Color(0xFF1b181f),
                                            appBar: AppBar(
                                              backgroundColor:
                                                  Color(0xFF312b35),
                                              iconTheme: IconThemeData(
                                                  color: Colors.white),
                                              title: Text(
                                                "Electronics",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              centerTitle: true,
                                            ),
                                            body: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2.39 / 4,
                                              ),
                                              itemCount: state.model.length,
                                              itemBuilder: (context, index) =>
                                                  Electronics(
                                                      model:
                                                          state.model[index]),
                                            ),
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Explore more",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 330,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (context, index) => SizedBox(
                                width: 250,
                                child: Electronics(
                                  model: state.model[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductSuccessState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Laptop",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            backgroundColor: Color(0xFF1b181f),
                                            appBar: AppBar(
                                              backgroundColor:
                                                  Color(0xFF312b35),
                                              iconTheme: IconThemeData(
                                                  color: Colors.white),
                                              title: Text(
                                                "Laptop",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              centerTitle: true,
                                            ),
                                            body: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2.8 / 4,
                                              ),
                                              itemCount: state.model.length,
                                              itemBuilder: (context, index) =>
                                                  Laptops(
                                                      model:
                                                          state.model[index]),
                                            ),
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    "Explore more",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 259,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (context, index) => SizedBox(
                                width: 200,
                                child: Laptops(
                                  model: state.model[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
