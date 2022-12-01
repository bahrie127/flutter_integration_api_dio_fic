import 'package:fic_rest_api/features/product/data/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fic_rest_api/features/product/data/models/medical_model.dart';

class ProductPageController extends StateNotifier<AsyncValue<List<Medical>?>> {
  Ref ref;
  ProductPageController(
    this.ref,
  ) : super(const AsyncData(null)) {
    getAll();
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    final response = await ref.read(productRepoProvider).getAll();
    state = response.fold(
      (l) => AsyncError(l.toString(), StackTrace.current),
      (r) => AsyncData(r),
    );
  }
}

final productControllerProvider =
    StateNotifierProvider<ProductPageController, AsyncValue<List<Medical>?>>(
        (ref) {
  return ProductPageController(ref);
});
