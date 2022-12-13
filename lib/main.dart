import 'package:api_prec/controller/get_task_controller.dart';
import 'package:api_prec/utils/Shared_prefutils.dart';
import 'package:api_prec/view/Home_screen.dart';
import 'package:api_prec/view/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? isLogin;

  @override
  void initState() {
    isLogin = SharedPrefutils.getLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetTaskController())
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: isLogin!.isEmpty ? LoginScreen() : const HomePage(),
        ),
      ),
    );
  }
}
