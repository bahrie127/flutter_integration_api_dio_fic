import 'package:fic_rest_api/features/product/presentation/cubit/product_cubit.dart';
import 'package:fic_rest_api/features/product/presentation/pages/cubit_product_page.dart';
import 'package:fic_rest_api/features/product/presentation/pages/product_page.dart';
import 'package:fic_rest_api/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'injection_container.dart' as di;
// import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => di.sl<ProductCubit>(),
        child: const CubitProductPage(),
      ),
    );
  }
}
