
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_and_login/main.dart';

import 'bloc_auth/cubit_auth.dart';
import 'localStorage/Shared_Preference.dart';

class Models extends StatelessWidget{
  final Widget deafModel;
  final Widget normalModel;
  final Widget welcomeModel;
  const Models({Key?key,
    required this.deafModel,
    required this.normalModel,
    required this.welcomeModel
  }):super(key: key);

  static bool isDeaf(BuildContext context)=>
      context.read<AuthCubit>().type=="true";

  static bool isNormal(BuildContext context)=>
      context.read<AuthCubit>().type=="false";

  static bool isWelcome(BuildContext context)=>
     context.read<AuthCubit>().type=="";

  @override
  Widget build(BuildContext context) {
    final String type= CacheNetwork.getFromCache(key: 'type').toLowerCase();
    print("modelscreen$type");
    if(type=="true"){
      return deafModel;
    }else if(type=="false"){
      return normalModel;
    }
    else if (type==""){
      return welcomeModel;
    }
    return const MyApp();
  }
}