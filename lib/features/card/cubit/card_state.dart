part of 'card_cubit.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

final class CardLoading extends CardState {}

final class AddCardSucess extends CardState {}

final class CardSucess extends CardState {
   final List<CardModel> cards;
  CardSucess({required this.cards});
}
final class CardRemoveState extends CardState {}
final class CardUpDateState extends CardState {}