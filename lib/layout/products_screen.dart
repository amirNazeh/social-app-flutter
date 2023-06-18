import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout_cubit/cubit.dart';
import 'package:shopapp/layout_cubit/states.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/styles/colors.dart';

import '../models/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuit,ShopStates>(
        listener: (context,state){},
       builder: (context,state){
       return ConditionalBuilder(
       condition: ShopCuit.get(context).homeModel !=null && ShopCuit.get(context).categoriesModel != null,
       builder: (context) => productsBuilder(ShopCuit.get(context).homeModel, ShopCuit.get(context).categoriesModel, context),
    fallback: (context) => Center(child: CircularProgressIndicator())
    );
    },
    );
    }
  }
Widget productsBuilder(HomeModel? model , CategoriesModel? categoriesModel , context) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model!.data!.banners.map((e) => Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
          ),).toList(),
          options: CarouselOptions(
          height: 250,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          )),

      SizedBox(
        height: 10,
      ),
      
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10
        ),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 130,
              child: ListView.separated(
                shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index)=>buildCatogoryItem(categoriesModel!.data!.data[index]),
                  separatorBuilder: (context , index)=>SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesModel!.data!.data.length
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'New Products',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing:1,
          childAspectRatio: 1/1.58,
          children: List.generate(
              model.data!.products.length,
                  (index) => buildGridProuct(model.data!.products[index],context),
          ),
        ),
      )
    ],
  ),
);

Widget buildGridProuct(ProductModel model, context) => Container(
  color: Colors.white,
  child:   Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(image: NetworkImage(model.image!),
              width: double.infinity,
              height:190
          ),
          if(model.discound != 0)
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
      Padding(
        padding: const EdgeInsets.all(12.0),
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
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: defaultColor,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                if(model.discound != 0)
                Text(
                  '${model.oldprice.round()}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),

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
);

Widget buildCatogoryItem( DataModel model) => Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage(model.image!),
      height: 130,
      width: 100,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100,
      color: Colors.black.withOpacity(.8),
      child: Text(
        model.name.toString(),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white
        ),
      ),
    )

  ],
);


