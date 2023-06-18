import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/login_cubit/states.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import '../network/end_points.dart';


class ShopLoginCuit extends Cubit<ShopLoginStates> {
  ShopLoginCuit() : super (ShopLoginInitialState());

  static ShopLoginCuit get(context) => BlocProvider.of(context);

  ShopLoginModel ?loginModel;
  void userLogin({
    @required String? email,
    @required String? password,

  })
  {
    emit(ShopLoginLoadigState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }


IconData suffix = Icons.visibility_outlined;
bool ispassworrd = true;
void changePasswordVisibility(){

  ispassworrd =! ispassworrd;
  suffix = ispassworrd?Icons.visibility_outlined: Icons.visibility_off_outlined;

  emit(ShopChangePasswodVisibilityState());
}
}