part of 'tshirt_cubit.dart';

@immutable
sealed class TshirtState {}

final class TshirtInitial extends TshirtState {}

final class TshirtLoading extends TshirtState {}

final class TshirtSuccessState extends TshirtState {
  final List<ModelTShirts> model;

  TshirtSuccessState({required this.model});
}
