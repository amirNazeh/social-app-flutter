import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/register/register_cubit/cubit.dart';
import 'package:shopapp/register/register_cubit/states.dart';

import '../network/local/cache_helper.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shop_Layout.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCuit(),
      child: BlocConsumer <ShopRegisterCuit,ShopRegisterStates>(
        listener: ( context,state)  {
          if(state is ShopRegisterSuccessState)
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
              }else
              {
                print(state.loginModel.message);
                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
                );
              }
            }
        },
        builder: (context,state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                  child:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                'REGISTER',
                                style:Theme.of(context).textTheme.headline5?.copyWith(
                                    color: Colors.black
                                ),

                              ),
                              Text(
                                'Register now to browse our hot offers',
                                style:Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey
                                ),

                              ),

                              defaultFormField(
                                controller:nameController ,
                                type: TextInputType.name,
                                validate: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'please enter your name';
                                  }
                                },
                                label: 'user name',
                                prefix: Icons.person,
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              defaultFormField(
                                controller:emailController ,
                                type: TextInputType.emailAddress,
                                isPassword: ShopRegisterCuit.get(context).ispassworrd,
                                suffix: ShopRegisterCuit.get(context).suffix,

                                suffixPressed: (){
                                  ShopRegisterCuit.get(context).changePasswordVisibility();
                                },
                                validate: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'email musn\'t be empty';
                                  }
                                },
                                label: 'Email ',
                                prefix: Icons.email_outlined,
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              defaultFormField(
                                controller:passwordController ,
                                type: TextInputType.visiblePassword,
                                isPassword: ShopRegisterCuit.get(context).ispassworrd,
                                suffix: ShopRegisterCuit.get(context).suffix,

                                suffixPressed: (){
                                  ShopRegisterCuit.get(context).changePasswordVisibility();
                                },
                                validate: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'please enter your password';
                                  }
                                },
                                label: 'Password ',
                                prefix: Icons.lock_outlined,
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              defaultFormField(
                                controller:phoneController ,
                                type: TextInputType.phone,
                                validate: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'please enter your phone number';
                                  }
                                },
                                label: 'Phone ',
                                prefix: Icons.phone,
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! ShopRegisterLoadigState,
                                builder: (context) => defaultButton(
                                  function: (){
                                    if(formKey.currentState!.validate()){
                                      ShopRegisterCuit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text
                                      );
                                    }

                                  },
                                  text: 'Register',
                                  isUpperCase: true,
                                ),
                                fallback:(context)=> Center(child: CircularProgressIndicator()),
                              ),
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
