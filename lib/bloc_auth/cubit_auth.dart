// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import '../localStorage/Shared_Preference.dart';
import 'cubit_states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthCubit extends Cubit<cubitStates> {
  AuthCubit() : super(AuthInitial());

  late String token;
  late String type;
  getFromCacheInStart({required String token,required String type}){
    this.type=type;
    this.token=token;
    emit(GetLocalState());
  }

  bool LogInLoading = false;

  login({required String username, required String password}) async {
    LogInLoading = true;
    emit(StartToLoginFun());
    print("start login");
    http.Response res = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/login/"),
        body: {'username': username, 'password': password});
    if (res.statusCode == 200) {
      print(res.body);
      var decode = json.decode(res.body);

      await CacheNetwork.setToCache(key: 'token', value:decode["token"] );
      await CacheNetwork.setToCache(key: 'type', value:decode["isDeaf"].toLowerCase());
      token=await CacheNetwork.getFromCache(key: 'token');
      type=await CacheNetwork.getFromCache(key: 'type').toLowerCase();

      print(token);
      print(type);
      emit(GetLoginFun());
    } else {
      print(jsonDecode(res.body));
      print('jfhdjfhjdhf');
    }
    LogInLoading = false;
    emit(EndToLoginFun());
  }

  ////////////////////////////////////////
  bool LogoutLoading = false;

  logout({required String token}) async {
    LogoutLoading = true;
    emit(StartToLogoutFun());
    try {
      print("start");
      http.Response res = await http.post(Uri.parse("http://10.0.2.2:8000/api/logout/"),
          headers: {
        'Authorization': 'Token $token',
         });
      if (res.statusCode == 200) {

        await CacheNetwork.deleteItemFromCache(key: 'token');
        await CacheNetwork.deleteItemFromCache(key: 'type');
        this.token=await CacheNetwork.getFromCache(key: 'token');
        type=await CacheNetwork.getFromCache(key: 'type').toLowerCase();
        print(type);
        print(res.body);
        String message = jsonDecode(res.body)["message"];
        print(message);
        emit(GetLogoutFun());
      } else {
        print(jsonDecode(res.body));
        print('404 me');
      }
    } catch (e) {
      print(e);
      emit(LogoutFailedState());
    }
    LogoutLoading = false;
    emit(EndToLogoutFun());
  }

  /////////////////////////////////////

  bool SignUpLoading = false;

  register({required String username, required String email,
      required String password, required String isDeaf}) async {
    SignUpLoading = true;
    emit(StartToSignUpFun());
    try {
      print("start register");
      http.Response res = await http.post(Uri.parse("http://10.0.2.2:8000/api/register/"),
          body: {
        'username': username,
        'password': password,
        'email': email,
        "isDeaf": isDeaf,
      });
      if (res.statusCode == 200) {
        print(res.body);
        var decode = json.decode(res.body);

        await CacheNetwork.setToCache(key: 'token', value:decode["token"]);
        await CacheNetwork.setToCache(key: 'type', value:decode["isDeaf"].toLowerCase());
        token=await CacheNetwork.getFromCache(key: 'token');
        type=await CacheNetwork.getFromCache(key: 'type').toLowerCase();

        print(token);
        print(type);
        emit(GetSignUpFun());
      } else {
        print(json.decode(res.body));
        print('jfhdjfhjdhf');
      }
    } catch (e) {
      print(e);
      emit(SignUpFailedState());
    }
    SignUpLoading = false;
    emit(EndToSignUpFun());
  }
}
