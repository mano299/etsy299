import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/fav_cubit.dart';
import '../../cubit/fav_state.dart';
import '../../model/fav_model.dart';

class FavHomeScreen extends StatelessWidget {
  const FavHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Favorites',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const _FavoritesContent(),
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  const _FavoritesContent();

  @override
  Widget build(BuildContext context) {
    final cubit = FavCubit.get(context);

    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        if (state is FavLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }

        if (state is FavSuccessState && state.favorites.isNotEmpty) {
          final List<FavModel> favs = state.favorites.cast<FavModel>();
          return _FilledState(favorites: favs, cubit: cubit);
        } else {
          return const _EmptyState();
        }
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.white54),
            const SizedBox(height: 20),
            const Text('No favorites yet',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            const Text(
              'Your favorite products will appear here.\nStart adding some!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/dummy_home_test');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Browse Products',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilledState extends StatelessWidget {
  final List<FavModel> favorites;
  final FavCubit cubit;

  const _FilledState({required this.favorites, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = favorites[index];
          return _ProductCard(product: product, cubit: cubit);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final FavModel product;
  final FavCubit cubit;

  const _ProductCard({required this.product, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Card(
          color: const Color(0xFF1F1F1F),
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade800,
                          child: const Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.white54, size: 40)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.favorite,
                            color: Colors.red, size: 22),
                        onPressed: () => cubit.removeFavorite(product),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.description.isEmpty
                          ? product.brand
                          : product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'USD ${double.tryParse(product.price)?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
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
