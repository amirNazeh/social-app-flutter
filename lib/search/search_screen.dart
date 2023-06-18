import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout_cubit/states.dart';
import 'package:shopapp/search/search_cubit/search_cubit.dart';
import 'package:shopapp/search/search_cubit/search_states.dart';
import 'package:shopapp/shared/components/components.dart';

import '../layout_cubit/cubit.dart';
import '../styles/colors.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
 var formKey = GlobalKey<FormState>();
 var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                 defaultFormField(
                     controller: searchController,
                     type: TextInputType.text,
                     validate: (String?value)
                   {
                     if(value!.isEmpty)
                       {
                         return'enter text to search';
                       }
                       return null;
                   },
                   onSubmit: (String text){
                       SearchCubit.get(context).search(text);
                   },
                     label: 'Search',
                     prefix: Icons.search,
                 ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLodingState )
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccesState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder:(context, index) =>  buildFavItem(SearchCubit.get(context).model!.data!.data![index] , context),
                        separatorBuilder:(context, index)=> myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ) ,
          );
        }),

      );

  }
}Widget buildFavItem( model , context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!),
              width: 120,
              height:120,
            ),
            if(model.discount != 0)
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
                model.name!,
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
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCuit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCuit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
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
