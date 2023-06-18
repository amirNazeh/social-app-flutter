import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/favorites_model.dart';

import '../layout_cubit/cubit.dart';
import '../layout_cubit/states.dart';
import '../shared/components/components.dart';
import '../styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavState,
            builder: (context)=> ListView.separated(
                itemBuilder:(context, index) =>  buildFavItem(ShopCuit.get(context).favoritesModel!.data!.data![index] , context),
                separatorBuilder:(context, index)=> myDivider(),
                itemCount: ShopCuit.get(context).favoritesModel!.data!.data!.length,
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator()) ,
          );
        }
    );
  }
}


Widget buildFavItem(FavoritesData model , context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.product!.image!),
              width: 120,
              height:120,
            ),
            if(model.product!.discount != 0)
              Container(
                  color: Colors.red,
                  child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5,),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 8,
                          color: Colors.white
                      ),),
                  )
              )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name!,
                maxLines:2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.product!.discount != 0)
                    Text(
                      model.product!.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),

                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCuit.get(context).changeFavorites(model.product!.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCuit.get(context).favorites[model.product!.id]! ? defaultColor : Colors.grey,
                        child: Icon(
                            Icons.favorite_border,
                            size:20,
                            color:Colors.white
                        ),
                      )
                  )

                ],

              ),
            ],
          ),
        ),

      ],

    ),
  ),
);