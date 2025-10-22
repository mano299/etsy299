import 'package:bloc/bloc.dart';
import 'package:etsy/features/Search/Electronics/data/data_products.dart';
import 'package:etsy/features/Search/Electronics/data/model_products.dart';
import 'package:meta/meta.dart';

part 'electronics_state.dart';

class ElectronicsCubit extends Cubit<ElectronicsState> {
  ElectronicsCubit() : super(ElectronicsInitial());

  getDataCubit() async {
    emit(ElectronicsLoading());
    emit(ElectronicsSuccessState(model: await DataProducts.getDataProducts()));
  }
}
