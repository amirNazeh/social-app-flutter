import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shop_Layout.dart';
import 'package:shopapp/register/shop_register_screen.dart';
import 'package:shopapp/shared/components/components.dart';

import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCuit(),
      child: BlocConsumer<ShopLoginCuit , ShopLoginStates>(
        listener: (context, state){

          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status!)
                {

                  CacheHelper.saveData(
                      key: 'token',
                      value: state.loginModel.data!.token
                  ).then((value) {

                    token =state.loginModel.data!.token!;
                    navigateAndFinish(context,ShopLayout());
                  });
                  //  Fluttertoast.showToast(
                  //      msg: state.loginModel.message!,
                  //      toastLength: Toast.LENGTH_SHORT,
                  //      gravity: ToastGravity.BOTTOM,
                  //      timeInSecForIosWeb: 5,
                  //      backgroundColor:  Colors.green,
                  //      textColor: Colors.white,
                  //      fontSize: 16.0
                  //  );
                }else
                  {
                    print(state.loginModel.message);
                    showToast(
                      text: state.loginModel.message,
                      state: ToastStates.ERROR,
                    );
                    // Fluttertoast.showToast(
                    //     msg: state.loginModel.message!,
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 5,
                    //     backgroundColor:  Colors.red,
                    //     textColor: Colors.white,
                    //     fontSize: 16.0
                    // );
                  }
            }

        },
        builder: (context , state){

          return Scaffold(
            appBar: AppBar(),
            body:Center(
                child:SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              'LOGIN',
                              style:Theme.of(context).textTheme.headline5?.copyWith(
                                  color: Colors.black
                              ),

                            ),
                            Text(
                              'login now to browse our hot offers',
                              style:Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.grey
                              ),

                            ),

                            defaultFormField(
                              controller:emailController ,
                              type: TextInputType.emailAddress,
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return'please enter your email adress';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            defaultFormField(
                              controller:passwordController ,
                              type: TextInputType.visiblePassword,
                              isPassword: ShopLoginCuit.get(context).ispassworrd,
                              suffix: ShopLoginCuit.get(context).suffix,

                              suffixPressed: (){
                                ShopLoginCuit.get(context).changePasswordVisibility();
                              },
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return'password is too short';
                                }
                              },
                              onSubmit:(value){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCuit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              label: 'Password ',
                              prefix: Icons.lock_outlined,
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadigState,
                              builder: (context) => defaultButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    ShopLoginCuit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                text: 'login',
                                isUpperCase: true,
                              ),
                              fallback:(context)=> Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Don\'t have an account ?'
                                ),
                                TextButton(
                                  onPressed: (){
                                    navigateTo(
                                      context,
                                      ShopRegisterScreen(),
                                    );
                                  },
                                  child: Text('register'),)
                              ],
                            )
                          ]
                      ),
                    ),
                  ),
                )
            ),

          );
        },
      ),
    );
  }
}
