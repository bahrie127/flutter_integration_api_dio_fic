import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic_rest_api/features/product/data/repositories/product_repository.dart';
import 'package:fic_rest_api/features/product/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required this.repo,
  }) : super(ProductInitial());

  final ProductRepository repo;

  void fetchProduct() async {
    final result = await repo.getAll();
    result.fold(
      (l) => emit(ProductFailed(errorMessage: l.toString())),
      (r) => emit(ProductLoaded(medicals: r)),
    );
  }
}
