import 'package:bloc/bloc.dart';
import 'package:etsy/features/login/data/data_login.dart';
import 'package:etsy/features/login/model/model_login.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginData data = LoginData();
  loginCubit({required String email, required String password}) async {
    emit(LoginLoading());
    var model = await LoginData.login(email: email, password: password);
    emit(LoginSucess(model: model));
  }

  registerCubit({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String nationalId,
    required String gender,
    required String profileImage,
  }) async {
    emit(LoginLoading());

    var response = await LoginData.registerData(
      email: email,
      password: password,
      name: name,
      phone: phone,
      nationalId: nationalId,
      gender: gender,
      profileImage: profileImage,
    );
  var model = LoginModel.fromJson(response ?? {"status": "error", "message": "No response"});
    emit(LoginSucess(model: model));
  }
}
