import 'package:fic_rest_api/features/product/presentation/controllers/product_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productControllerProvider);
    return Scaffold(
      body: productState.when(
        data: (data) {
          if (data == null) {
            return const Text('no data');
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              return Card(
                child: ListTile(
                  title: Text(data[index].attributes.name),
                  subtitle: Text(data[index].attributes.description),
                ),
              );
            },
            itemCount: data.length,
          );
        },
        error: (error, _) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
