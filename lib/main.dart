import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/hive/hive_init.dart';
import 'package:todo_app/core/utils/main_theme.dart';
import 'package:todo_app/core/utils/routers.dart';
import 'package:todo_app/screens/provider/category_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveData.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final RouteGenerator _router = RouteGenerator();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CategoryProvider())],
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: MainTheme.light,
        initialRoute: "/",
        onGenerateRoute: _router.routeGenerate,
      ),
    );
  }
}
