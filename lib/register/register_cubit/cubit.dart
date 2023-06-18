import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/register/register_cubit/states.dart';
import '../../network/end_points.dart';



class ShopRegisterCuit extends Cubit<ShopRegisterStates> {
  ShopRegisterCuit() : super (ShopRegisterInitialState());

  static ShopRegisterCuit get(context) => BlocProvider.of(context);

  ShopLoginModel ?loginModel;
  void userRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,

  })
  {
    emit(ShopRegisterLoadigState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


IconData suffix = Icons.visibility_outlined;
bool ispassworrd = true;
void changePasswordVisibility(){

  ispassworrd =! ispassworrd;
  suffix = ispassworrd?Icons.visibility_outlined: Icons.visibility_off_outlined;

  emit(ShopChangeRegisterPasswodVisibilityState());
}
}