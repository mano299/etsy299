import 'package:bloc/bloc.dart';
import 'package:etsy/features/Search/products/model/product_data.dart';
import 'package:etsy/features/Search/products/model/product_model.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  getDataCubit() async {
    emit(ProductLoadingState());
    emit(ProductSuccessState(model: await ProductData.getData()));
  }
}
