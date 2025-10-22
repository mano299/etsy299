
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
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Favorites',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
                Icons.search,
                color: Colors.white
            ),
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
        if (state is FavLoadingState)
        {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (state is FavSuccessState && state.favorites.isNotEmpty)
        {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 50,
                  color: Colors.white70
              ),

              const SizedBox(height: 20),

              const Text(
                  'No favorites yet',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  )
              ),

              const SizedBox(height: 5),

              const Text(
                  'Your recommendations get better as you favorite more things.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey
                  )
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/dummy_home_test');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                    'We think you\'ll like these',
                    style: TextStyle(
                        color: Colors.white
                    )
                ),
              ),
            ],
          ),
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
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.65,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];
        return _ProductCard(product: product, cubit: cubit);
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final FavModel product;
  final FavCubit cubit;

  const _ProductCard({required this.product, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade800,
                    child: const Center(
                        child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white70
                        )
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20
                    ),
                    onPressed: () => cubit.removeFavorite(product),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.description.isEmpty ? product.brand : product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'USD ${double.tryParse(product.price)?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          shape: BoxShape.circle
                      ),
                      child: IconButton(
                        icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                            color: Colors.white
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}