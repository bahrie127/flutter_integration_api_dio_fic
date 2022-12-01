import 'package:dio/dio.dart';
import 'package:fic_rest_api/features/product/data/models/medical_model.dart';
import 'package:fic_rest_api/models/request_model.dart';

class NetworkManager {
  late Dio _dio;

  String baseUrl = 'https://fic-app-fry88.ondigitalocean.app/api';

  NetworkManager() {
    _dio = Dio();
  }

  Future<MedicalModel> getAll() async {
    final response = await _dio.get(
      "$baseUrl/medicals",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    return MedicalModel.fromJson(response.data);
  }

  Future<void> addData(RequestMedical request) async {
    String url = '$baseUrl/medicals';
    final response = await _dio.post(url,
        // options: Options(
        //   headers: {
        //     "Content-Type": "application/json",
        //   },
        // ),
        data: {
          'data': request.toMap(),
        });

    print(response.toString());
  }

  Future<void> updateData(int id, RequestMedical requestMedical) async {
    var response = await _dio.put(
      "$baseUrl/medicals/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {"data": requestMedical.toMap()},
    );
    Map obj = response.data;
  }

  Future<void> deleteData(int id) async {
    var response = await Dio().delete(
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      "$baseUrl/medicals/$id",
    );
    print(response.statusCode);
  }
}
