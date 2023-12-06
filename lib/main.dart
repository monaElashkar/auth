import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'Screens/models/home_screen.dart';
import 'bloc_auth/cubit_auth.dart';
import 'constant.dart';
import 'localStorage/Shared_Preference.dart';

String? token;
String? type;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token =CacheNetwork.getFromCache(key: 'token');
  type = CacheNetwork.getFromCache(key: 'type').toLowerCase();
  print("main$type");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider
        (create:
          ((context)=>AuthCubit()..getFromCacheInStart(token:token!, type: type!)
          )
        ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0, backgroundColor: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            ),
            radioTheme: RadioThemeData(
              fillColor: MaterialStateColor.resolveWith((states) => kPrimaryColor), //<-- SEE HERE
            )
        ),
        home: const Home(),
      ),
    );
  }
}
