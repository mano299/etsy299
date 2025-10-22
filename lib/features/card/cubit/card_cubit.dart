
import 'package:etsy/features/card/data/data_card.dart';
import 'package:etsy/features/card/model/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());
  static CardCubit get(context) => BlocProvider.of(context);
  CardData cardData = CardData();

  addCardCubit({required String productId}) async {
    emit(CardLoading());
    await cardData.addCart(productId: productId);
    emit(AddCardSucess());
    await getCardCubit();
  }

  getCardCubit() async {
    emit(CardLoading());
    var cards = await cardData.getCard();
    emit(CardSucess(cards: cards));
  }

  removeCard({required String id}) async {
    emit(CardLoading());
    await cardData.getData(id: id);
    await getCardCubit();
  }

  upDateCubit({required String productId, required num quantity}) async {
    emit(CardLoading());
    await cardData.updateData(productId: productId, quantity: quantity);
    emit(CardUpDateState());
    await getCardCubit();
  }
}
