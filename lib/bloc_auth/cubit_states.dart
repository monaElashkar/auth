// ignore_for_file: camel_case_types

abstract class cubitStates{}
class AuthInitial extends cubitStates{}

class StartToLoginFun extends cubitStates{}
class GetLoginFun extends cubitStates{}
class EndToLoginFun extends cubitStates{}
class LogInFailedState extends cubitStates{}

class StartToSignUpFun extends cubitStates{}
class GetSignUpFun extends cubitStates{}
class EndToSignUpFun extends cubitStates{}
class SignUpFailedState extends cubitStates{}

class StartToLogoutFun extends cubitStates{}
class GetLogoutFun extends cubitStates{}
class EndToLogoutFun extends cubitStates{}
class LogoutFailedState extends cubitStates{}

class GetLocalState extends cubitStates{}