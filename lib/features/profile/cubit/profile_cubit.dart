
import 'package:bloc/bloc.dart';

import '../data/data.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUserData() async {
    emit(ProfileLoading());
    final userData = await User.getUserData();
    emit(ProfileSuccess(userData));
  }

  profileDelete() {
    emit(ProfileDeleteloading());
    User.deleteUser(
      email: "eewu2w@gmail.com",
      password: "12345467893",
    );
    emit(ProfileDeleteSuccess());
    getUserData();
  }

  void updateUserData({
  required String name,
  required String phone,
}) async {
  emit(ProfileUpdateLoading());

  await User.updateUserData(
    name: name,
    phone: phone,
  );

  emit(ProfileUpdated());
  getUserData(); 
}


}
