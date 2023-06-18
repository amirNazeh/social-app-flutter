
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout_cubit/cubit.dart';
import 'package:shopapp/layout_cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';

import '../shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
 var formKey  = GlobalKey<FormState>();
 var nameController = TextEditingController();
 var emailController = TextEditingController();
 var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCuit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model!.data!.email!;
        phoneController.text = model!.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCuit.get(context).userModel != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  defaultFormField
                    (controller: nameController,
                      type: TextInputType.name,
                      validate: (String ?value){
                        if(value!.isEmpty)
                        {
                          return 'name must\'t be empty ';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField
                    (controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String ?value){
                      if(value!.isEmpty)
                      {
                        return 'email must\'t be empty ';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField
                    (controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String ?value){
                        if(value!.isEmpty)
                        {
                          return 'phone must\'t be empty ';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopCuit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },
                      text: 'Update'
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  defaultButton(
                      function: (){
                        signOut(context);
                      },
                      text: 'Logout'
                  )
                ],
              ),
            ),
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );

      });


  }
}
