

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout_cubit/cubit.dart';
import 'package:shopapp/layout_cubit/states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuit, ShopStates>(
      listener: (context, state) {
         if(state is ShopSuccessChangeFavoritesState)
           if(!state.model!.status!)(
           showToast(
               text: state.model!.message,
               state: ToastStates.ERROR)
           );
      },
       builder: (context, state) {
         return ListView.separated(
             itemBuilder:(context, index) =>  buildCaItem(ShopCuit.get(context).categoriesModel!.data!.data[index]),
             separatorBuilder:(context, index)=> myDivider(),
             itemCount: ShopCuit.get(context).categoriesModel!.data!.data.length
         );
       }
    );
  }
}

Widget buildCaItem(DataModel model) =>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(model.image!),
        width: 80,
        height: 80,
        fit: BoxFit.cover
        ,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        model.name!,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      )
    ],
  ),
);
