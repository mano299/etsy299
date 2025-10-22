import 'package:etsy/features/card/model/card_model.dart';
import 'package:meta/meta.dart';

enum CartSource { realApi, fake }

class UnifiedCartItem {
  final CardModel item;
  final CartSource source;

  UnifiedCartItem({
    required this.item,
    required this.source,
  });
}

@immutable
sealed class UnifiedCartState {}

final class UnifiedCartInitial extends UnifiedCartState {}

final class UnifiedCartLoading extends UnifiedCartState {}

final class UnifiedCartLoaded extends UnifiedCartState {
  final List<UnifiedCartItem> items;
  UnifiedCartLoaded({required this.items});
}