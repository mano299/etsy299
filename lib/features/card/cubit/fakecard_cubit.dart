import 'package:bloc/bloc.dart';
import 'package:etsy/features/card/model/card_model.dart';
import 'package:meta/meta.dart';

part 'fakecard_state.dart';

class FakeCardCubit extends Cubit<FakecardState> {
  FakeCardCubit() : super(FakecardInitial());

  List<CardModel> fakeCart = [];

  void addToFakeCart(CardModel product) {
    final index = fakeCart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      fakeCart[index].quantity++;
    } else {
      fakeCart.add(product);
    }
emit(FakecardUpdate(fakeCard: List.from(fakeCart)));  }

  void removeFromFakeCart(String id) {
    fakeCart.removeWhere((item) => item.id == id);
emit(FakecardUpdate(fakeCard: List.from(fakeCart)));  }

  void increaseQuantity(String id) {
    final index = fakeCart.indexWhere((item) => item.id == id);
    if (index != -1) {
      fakeCart[index].quantity++;
emit(FakecardUpdate(fakeCard: List.from(fakeCart)));    }
  }

  void decreaseQuantity(String id) {
    final index = fakeCart.indexWhere((item) => item.id == id);
    if (index != -1 && fakeCart[index].quantity > 1) {
      fakeCart[index].quantity--;
emit(FakecardUpdate(fakeCard: List.from(fakeCart)));    }
  }

}

