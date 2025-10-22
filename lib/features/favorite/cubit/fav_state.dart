import '../model/fav_model.dart';

abstract class FavState {}
class FavInitialState extends FavState {}

class FavLoadingState extends FavState {}

class FavUpdatedState extends FavState {}

class FavSuccessState extends FavState {
  final List<FavModel> favorites;
  FavSuccessState(this.favorites);
}

class FavErrorState extends FavState {
  final String message;
  FavErrorState(this.message);
}
