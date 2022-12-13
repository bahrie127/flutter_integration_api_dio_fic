import 'package:dartz/dartz.dart';
import 'package:fic_rest_api/features/product/data/models/medical_model.dart';
import 'package:fic_rest_api/features/product/data/repositories/product_repository.dart';
import 'package:fic_rest_api/features/product/presentation/controllers/product_page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepo extends Mock implements ProductRepository {}

void main() {
  group('ProductPageController', () {
    test('get all success', () async {
      final productRepo = MockProductRepo();
      when(productRepo.getAll).thenAnswer((_) => Future.value(const Right([])));

      final controller = ProductPageController(productRepo);
      await controller.getAll();

      expect(controller.debugState, const AsyncData<List<Medical>?>([]));
    });

    test('get all failed', () async {
      final productRepo = MockProductRepo();
      when(productRepo.getAll)
          .thenAnswer((_) => Future.value(const Left('internal server error')));

      final controller = ProductPageController(productRepo);
      await controller.getAll();

      expect(
          controller.debugState,
          const AsyncError<List<Medical>?>(
              'internal server error', StackTrace.empty));
    });
  });
}
