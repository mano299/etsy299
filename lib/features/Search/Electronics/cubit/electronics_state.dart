part of 'electronics_cubit.dart';

@immutable
sealed class ElectronicsState {}

final class ElectronicsInitial extends ElectronicsState {}

final class ElectronicsLoading extends ElectronicsState {}

final class ElectronicsSuccessState extends ElectronicsState {
  final List<ModelProducts> model;

  ElectronicsSuccessState({required this.model});
}
