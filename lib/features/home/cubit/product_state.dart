import 'package:etsy/features/home/data/model.dart';


sealed class ProductState {}

final class ProductInitial extends ProductState {}
final class ProductLoadingState extends ProductState {}
final class ProductSuccessState extends ProductState {
  final List<ProductModel> list;

  ProductSuccessState({required this.list});
}