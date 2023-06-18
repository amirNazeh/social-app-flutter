


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../network/local/cache_helper.dart';
import '../../shop_login_screen.dart';



Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultFormField({
      @required TextEditingController? controller,
      @required TextInputType ?type,
      void Function(String)? onSubmit,
      void Function(String)? onChange,
      void Function()? onTap,
       bool isPassword = false,
     String? Function(String?)? validate,
      @required String? label,
      @required IconData? prefix,
      IconData? suffix,
      void Function() ?suffixPressed,
      bool isClickable = true,
}) =>
    TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          enabled: isClickable,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap,
          validator: validate,
          decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(
                      prefix,
                ),
                suffixIcon: suffix != null
                    ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(
                            suffix,
                      ),
                )
                    : null,
                border: OutlineInputBorder(),
          ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );



void showToast({
  @required String? text,
  @required ToastStates? state,
})=> Fluttertoast.showToast(
msg: text!,
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state!),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates {SUCCESS ,ERROR ,WARNING}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
      case ToastStates.ERROR:
      color = Colors.red;
      break;
      case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;

}

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);