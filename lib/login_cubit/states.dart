import 'package:shopapp/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadigState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;

   ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswodVisibilityState extends ShopLoginStates{}