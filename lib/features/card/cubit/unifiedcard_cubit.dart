import 'dart:async';
import 'package:etsy/features/card/cubit/card_cubit.dart';
import 'package:etsy/features/card/cubit/fakecard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'unifiedcard_state.dart';

class UnifiedCartCubit extends Cubit<UnifiedCartState> {
  final CardCubit realCubit;
  final FakeCardCubit fakeCubit;

  late final StreamSubscription realSub;
  late final StreamSubscription fakeSub;

  UnifiedCartCubit({
    required this.realCubit,
    required this.fakeCubit,
  }) : super(UnifiedCartInitial()) {
    realSub = realCubit.stream.listen((_) => _mergeAndEmit());
    fakeSub = fakeCubit.stream.listen((_) => _mergeAndEmit());
    _mergeAndEmit();
  }

  void _mergeAndEmit() {
    emit(UnifiedCartLoading());

    final List<UnifiedCartItem> unified = [];

    final s = realCubit.state;
    if (s is CardSucess) {
      for (final e in s.cards) {
        unified.add(UnifiedCartItem(item: e, source: CartSource.realApi));
      }
    }

    final fs = fakeCubit.state;
    if (fs is FakecardUpdate) {
      for (final e in fs.fakeCard) {
        unified.add(UnifiedCartItem(item: e, source: CartSource.fake));
      }
    }

    emit(UnifiedCartLoaded(items: unified));
  }

  void removeUnifiedItem(UnifiedCartItem item) {
    if (item.source == CartSource.realApi) {
      realCubit.removeCard(id: item.item.id);
    } else {
      fakeCubit.removeFromFakeCart(item.item.id);
    }
  }
  void increaseUnifiedQuantity(UnifiedCartItem item) {
  if (item.source == CartSource.realApi) {
    realCubit.upDateCubit(
      productId: item.item.id,
      quantity: item.item.quantity + 1,
    );
  } else {
    fakeCubit.increaseQuantity(item.item.id);
  }
}

void decreaseUnifiedQuantity(UnifiedCartItem item) {
  if (item.source == CartSource.realApi) {
    if (item.item.quantity > 1) {
      realCubit.upDateCubit(
        productId: item.item.id,
        quantity: item.item.quantity - 1,
      );
    } else {
      realCubit.removeCard(id: item.item.id);
    }
  } else {
    fakeCubit.decreaseQuantity(item.item.id);
  }
}

  @override
  Future<void> close() {
    realSub.cancel();
    fakeSub.cancel();
    return super.close();
  }
}