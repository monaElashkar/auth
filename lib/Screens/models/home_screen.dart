import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_and_login/model_screen.dart';

import '../../bloc_auth/cubit_auth.dart';
import '../../localStorage/Shared_Preference.dart';
import '../Welcome/welcome_screen.dart';
import 'components/deafModel_home_screen.dart';
import 'components/normalModel_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 @override
  void initState() {
   context.read<AuthCubit>().type= CacheNetwork.getFromCache(key: 'type').toLowerCase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //context.read<AuthCubit>().type== CacheNetwork.getFromCache(key: 'type').toLowerCase();
    return const Models(
        deafModel:DeafModelHome(),
        normalModel: NormalModelHome(),
        welcomeModel:WelcomeScreen()
    );
  }
}
