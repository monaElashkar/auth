// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_and_login/bloc_auth/cubit_auth.dart';

import '../../../bloc_auth/cubit_states.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constant.dart';
import '../../../localStorage/Shared_Preference.dart';
import '../../../main.dart';
import '../../Login/login_screen.dart';
import '../../models/home_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}
List<String> options=["true","false"];
class _SignUpFormState extends State<SignUpForm> {
  late String _username, _password,_email;

  String _isDeaf='' ;
  bool isDeafError=false;
  bool _obscureText=true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit,cubitStates>(
        listener:(context,state)async{
          type = await CacheNetwork.getFromCache(key: 'type').toLowerCase();

          print("value$type");

          if(state is GetSignUpFun){
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=> const Home()
            ));
          }else if(state is SignUpFailedState){
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
                onSaved: (username) {
                  _username=username!;
                },
                validator:(input)
                {
                  if(input == null ||input.isEmpty){
                    return 'please type username';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "User Name",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
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
                    hintText: "Your email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
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
              Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kPrimaryLightColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left:defaultPadding+25 ,top: 10),
                            child: Text("Type :",style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: options[0],
                                      groupValue: _isDeaf,
                                      onChanged: (value){
                                        setState(() {
                                          _isDeaf=value.toString();
                                          isDeafError=false;
                                          print(_isDeaf);
                                        });

                                      }
                                  ),
                                  const Text("Deaf",style: TextStyle(color: Colors.black45,fontSize: 18),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: options[1],
                                      groupValue: _isDeaf,
                                      onChanged: (value){
                                        setState(() {
                                          _isDeaf=value.toString();
                                          isDeafError=false;
                                          print(_isDeaf);
                                        });

                                      }
                                  ),
                                  const Text("Not Deaf",style: TextStyle(color: Colors.black45,fontSize: 18),)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:defaultPadding ,top:5),
                      child: Text("chose type",
                        style: TextStyle(color:isDeafError==true? Colors.red:Colors.white,fontSize: 13),),
                    ),


                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate()&& _isDeaf!=''){
                    _formkey.currentState!.save();
                    cubit.register(username: _username, email: _email, password: _password,isDeaf: _isDeaf);
                  }else if(_isDeaf==''){
                   isDeafError=true;
                   setState(() {

                   });
                  }else if(_isDeaf=='true'||_isDeaf=='false'){
                    isDeafError=false;
                    setState(() {

                    });
                  }
                },
                child: Text("Sign Up".toUpperCase()),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: defaultPadding+defaultPadding),

            ],
          ),
        );
      }
    );
  }
}