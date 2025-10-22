import 'package:bloc/bloc.dart';
import 'package:etsy/features/home/cubit/product_state.dart';
import 'package:etsy/features/home/data/data.dart';
import 'package:etsy/features/home/data/model.dart';
import 'package:meta/meta.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  getDataCubit() async {
    emit(ProductLoadingState());

    try {
      List<ProductModel> products = await ProductData.getData();
      emit(ProductSuccessState(list: products));
    } catch (e) {
      emit(ProductLoadingState());
    }
  }
}
