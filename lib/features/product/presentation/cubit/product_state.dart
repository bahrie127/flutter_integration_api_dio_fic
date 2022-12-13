import 'package:fic_rest_api/features/product/data/models/medical_model.dart';

abstract class ProductState {}

class ProductLoaded extends ProductState {
  final List<Medical> medicals;
  ProductLoaded({
    required this.medicals,
  });
}

class ProductInitial extends ProductState{}

class ProductFailed extends ProductState {
  final String errorMessage;
  ProductFailed({
    required this.errorMessage,
  });
}
