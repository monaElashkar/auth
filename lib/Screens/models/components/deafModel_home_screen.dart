import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc_auth/cubit_auth.dart';
import '../../../constant.dart';
import '../../Welcome/welcome_screen.dart';

class DeafModelHome extends StatefulWidget {
  const DeafModelHome({Key? key}) : super(key: key);

  @override
  State<DeafModelHome> createState() => _DeafModelHomeState();
}

class _DeafModelHomeState extends State<DeafModelHome> {
  @override
  Widget build(BuildContext context) {
   return Container(
      color: kPrimaryLightColor,
      child: Column(
        children: [
          const SizedBox(height: 175,),
          const Text("home page for deaf model",style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            decoration:TextDecoration.none,
          ),),
          const SizedBox(height: 300,),
          GestureDetector(
            onTap: (){
              BlocProvider.of<AuthCubit>(context).logout(token: BlocProvider.of<AuthCubit>(context).token);
              Navigator.pushAndRemoveUntil<void>(
                  context, MaterialPageRoute(
                  builder: ((context) => const WelcomeScreen())),(Route<dynamic> route) => false);

            },
            child: Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kPrimaryColor,
              ),
              child: const Center(
                child: Text("logout",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration:TextDecoration.none,
                ),),
              ),
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(

                builder: ((context) => const WelcomeScreen())));
          }, child:const Text("welcome page",style: TextStyle(
              color: Color(0xff0AAB98),fontSize: 18),),)
        ],
      ),
    );
  }
}
