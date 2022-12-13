
import 'package:fic_rest_api/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:fic_rest_api/features/product/data/repositories/product_repository.dart';
import 'package:fic_rest_api/features/product/presentation/cubit/product_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ProductRemoteDataSource());
  sl.registerLazySingleton(() => ProductRepository(dataSource: sl()));
  
  sl.registerLazySingleton(() => ProductCubit(repo: sl()));
}