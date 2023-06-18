
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/categories_screen.dart';
import 'package:shopapp/layout/favorites_sceen.dart';
import 'package:shopapp/layout/products_screen.dart';
import 'package:shopapp/layout/setting_screen.dart';
import 'package:shopapp/layout_cubit/states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

import '../models/home_model.dart';
import '../models/search_model.dart';
import '../network/end_points.dart';
import '../shared/components/components.dart';
import 'package:shopapp/main.dart';

import '../shared/components/constants.dart';


class ShopCuit extends Cubit<ShopStates> {
  ShopCuit() : super (ShopInitialState());

  static ShopCuit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int? , bool?> favorites = {};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value){
      homeModel = HomeModel.fromjson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });
     // printFullText(homeModel!.data!.banners[0].image!);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){

    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesState());

   DioHelper.postData(
     url: FAVORITES,
     data: {
       'product_id':productId,
     },
       token: token,
   )
       .then((value){
         changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
         if(!changeFavoritesModel!.status!)
           {
             favorites[productId] =! favorites[productId]!;
           }else
             {
               getFavorites();
             }

         emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
   })
       .catchError((error){
         favorites[productId] =! favorites[productId]!;
         emit(ShopErrorChangeFavoritesState());
   });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
     @required String? name,
     @required String? email,
     @required String? phone,
    })
    {
    emit(ShopLoadingUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value){
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

}