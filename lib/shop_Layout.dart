

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/search/search_screen.dart';
import 'package:shopapp/layout/setting_screen.dart';
import 'package:shopapp/shared/components/components.dart';

import 'layout_cubit/cubit.dart';
import 'layout_cubit/states.dart';

class ShopLayout extends StatelessWidget {
   ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCuit , ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = ShopCuit.get(context);

          return Scaffold(

            appBar: AppBar(
              title:Text('salla'),
              actions: [
                IconButton(
                icon: Icon(Icons.search),
                    onPressed: (){
                  navigateTo(context, SearchScreen());
                    }
                    )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon:Icon (Icons.home),
                label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon:Icon (Icons.apps),
                label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon:Icon (Icons.favorite),
                label: 'Favorite'
                ),
                BottomNavigationBarItem(
                    icon:Icon (Icons.settings),
                label: 'Settings'
                ),
              ],
            ),
          );
        });
  }
}
