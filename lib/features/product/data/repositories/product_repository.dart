import 'package:dartz/dartz.dart';
import 'package:fic_rest_api/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:fic_rest_api/features/product/data/models/medical_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductRepository {
  final ProductRemoteDataSource dataSource;
  ProductRepository({
    required this.dataSource,
  });

  Future<Either<String, List<Medical>>> getAll() async {
    try{
      final response = await dataSource.getAll();
      return Right(response.data);
    }catch (e){
      return Left(e.toString());
    }
  }
}

final productRepoProvider = Provider<ProductRepository>((ref) {
  final sourceProvider = ref.watch(productDataSourceProvider);
  return ProductRepository(dataSource: sourceProvider) ;
});
