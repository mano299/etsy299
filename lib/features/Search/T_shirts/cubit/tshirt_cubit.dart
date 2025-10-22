import 'package:bloc/bloc.dart';
import 'package:etsy/features/Search/T_shirts/data/data_t_shirts.dart';
import 'package:etsy/features/Search/T_shirts/data/model_t_shirts.dart';
import 'package:meta/meta.dart';

part 'tshirt_state.dart';

class TshirtCubit extends Cubit<TshirtState> {
  TshirtCubit() : super(TshirtInitial());

  getDataCubit() async {
    emit(TshirtLoading());
    emit(TshirtSuccessState(model: await DataTShirts.getDataTShirts()));
  }
}
