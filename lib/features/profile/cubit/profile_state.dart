
import '../data/models/user_model.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userData;
  ProfileSuccess(this.userData);
}

final class ProfileDeleteSuccess extends ProfileState {}
final class ProfileUpdated extends ProfileState {}
final class ProfileUpdateLoading extends ProfileState {}

final class ProfileDeleteloading extends ProfileState {}
