import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fic_rest_api/features/product/data/models/medical_model.dart';
import 'package:fic_rest_api/features/product/data/repositories/product_repository.dart';

class ProductPageController extends StateNotifier<AsyncValue<List<Medical>?>> {
  // Ref ref;
  ProductRepository productRepository;
  ProductPageController(
    this.productRepository,
  ) : super(const AsyncData(null)) {
    getAll();
  }

  Future<void> getAll() async {
    state = const AsyncLoading();
    final response = await productRepository.getAll();
    state = response.fold(
      (left) => AsyncError(left.toString(), StackTrace.empty),
      (right) => AsyncData(right),
    );
  }
}

final productControllerProvider =
    StateNotifierProvider<ProductPageController, AsyncValue<List<Medical>?>>(
        (ref) {
  final repo = ref.read(productRepoProvider);
  return ProductPageController(repo);
});
