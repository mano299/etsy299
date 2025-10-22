part of 'fakecard_cubit.dart';

@immutable
sealed class FakecardState {}

final class FakecardInitial extends FakecardState {}

final class FakecardUpdate extends FakecardState {
  final List<CardModel> fakeCard;
  FakecardUpdate({required this.fakeCard});
}

