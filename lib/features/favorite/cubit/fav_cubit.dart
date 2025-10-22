import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/fav_data.dart';
import '../model/fav_model.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitialState());
  List<FavModel> favorites = [];

  Future<void> loadFavorites() async {
    emit(FavLoadingState());
    try {
      favorites = await FavData.getAllData();
      emit(FavSuccessState(favorites));
    } catch (err) {
      emit(FavErrorState('Failed to load favorites'));
      print('err');
    }
  }

  void addFavorite(FavModel product) {
    favorites.add(product);
    emit(FavSuccessState(favorites));
  }

  void removeFavorite(FavModel product) {
    favorites.remove(product);
    emit(FavSuccessState(favorites));
  }

  bool isFavorite(FavModel product) {
    return favorites.contains(product);
  }

  static FavCubit get(context) => BlocProvider.of<FavCubit>(context);
}
