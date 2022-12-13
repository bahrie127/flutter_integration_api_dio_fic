import 'package:fic_rest_api/features/product/presentation/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_state.dart';

class CubitProductPage extends StatefulWidget {
  const CubitProductPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<CubitProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Builder(builder: (context) {
            final state = context.watch<ProductCubit>().state;
            if (state is ProductInitial) {
              context.read<ProductCubit>().fetchProduct();
            }
            if (state is ProductFailed) {
              return Text(state.errorMessage);
            }
            if (state is ProductLoaded) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.medicals[index].attributes.name),
                      subtitle:
                          Text(state.medicals[index].attributes.description),
                    ),
                  );
                },
                itemCount: state.medicals.length,
              );
            }
            return const CircularProgressIndicator();
          }),
        ),
        Expanded(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                context.read<ProductCubit>().fetchProduct();
              }
              if (state is ProductFailed) {
                return Text(state.errorMessage);
              }
              if (state is ProductLoaded) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.medicals[index].attributes.name),
                        subtitle:
                            Text(state.medicals[index].attributes.description),
                      ),
                    );
                  },
                  itemCount: state.medicals.length,
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    )

        // productState.when(
        //   data: (data) {
        //     if (data == null) {
        //       return const Text('no data');
        //     }
        //     return ListView.builder(
        //       itemBuilder: (_, index) {
        //         return Card(
        //           child: ListTile(
        //             title: Text(data[index].attributes.name),
        //             subtitle: Text(data[index].attributes.description),
        //           ),
        //         );
        //       },
        //       itemCount: data.length,
        //     );
        //   },
        //   error: (error, _) => Text(error.toString()),
        //   loading: () => const CircularProgressIndicator(),
        // ),
        );
  }
}
