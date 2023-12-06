// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc_auth/cubit_auth.dart';
import '../../../bloc_auth/cubit_states.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constant.dart';
import '../../../localStorage/Shared_Preference.dart';
import '../../../main.dart';
import '../../Signup/signup_screen.dart';
import '../../models/home_screen.dart';

class LoginForm extends StatefulWidget {
   const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email, _password;
  bool _obscureText=true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit,cubitStates>(
        listener:(context,state)async{
          type = await CacheNetwork.getFromCache(key: 'type').toLowerCase();

          print("value$type");

          if(state is GetLoginFun){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=> const Home()
            ));
          }else if(state is LogInFailedState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
              alignment: Alignment.center,
              child: const Text("something wrong try again"),)));
          }
        },
      builder: (context,state) {
        return Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {
                  _email=email!;
                },
                validator:(input)
                {
                   if(input == null ||input.isEmpty){
                      return 'please type email';
                    }
                    return null;
                },
                decoration: const InputDecoration(
                  hintText: "Your Email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.done,
                  cursorColor: kPrimaryColor,
                  onSaved: (pass) {
                    _password=pass!;
                  },
                  validator:(input){
                    if(input == null ||input.isEmpty){
                      return 'please type Password';
                    }
                    return null;
                  },

                  decoration:  InputDecoration(
                    hintText: "Your password",
                    suffixIcon:Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: InkWell(
                          onTap: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                          child: Icon(
                            _obscureText
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,color: kPrimaryColor,
                          )),
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () async{
                  if(_formkey.currentState!.validate()){
                    _formkey.currentState!.save();
                    cubit.login(username: _email,password: _password);
                  }
                },
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
