import 'package:dio/dio.dart';
import 'package:fic_rest_api/core/api/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/medical_model.dart';

class ProductRemoteDataSource {
  late Dio _dio;

  ProductRemoteDataSource() {
    _dio = Dio(BaseOptions(
        baseUrl: Endpoints.baseUrl,
        responseType: ResponseType.json,
        headers: {
          "Content-Type": "application/json",
        }));
  }

  Future<MedicalModel> getAll() async {
    final response = await _dio.get(
      Endpoints.productUrl,
    );
    return MedicalModel.fromJson(response.data);
  }
}

final productDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSource();
});
