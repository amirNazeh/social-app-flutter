import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout_cubit/cubit.dart';
import 'package:shopapp/shared/bloc_observer.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shop_Layout.dart';
import 'package:shopapp/shop_login_screen.dart';
import 'package:shopapp/styles/themes.dart';
import 'Theme_cubit/theme_state.dart';
import 'Theme_cubit/themecubit.dart';
import 'login_cubit/cubit.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'on_boarding.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
   DioHelper.init();
   await CacheHelper.init();

   bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

   bool? onBoarding= CacheHelper.getData(key: 'onBoarding');

     token = CacheHelper.getData(key: 'token');

    if(onBoarding != null)
      {
        if(token != null) widget= ShopLayout();
        else widget = ShopLoginScreen();
      }else
        {
      widget= OnBoardingScreen();
    }

  runApp(MyApp(
      isDark:isDark ,
      startWidget:widget ));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key key}) : super(key: key);

 final bool? isDark;
 final Widget? startWidget;
     MyApp({
       this.isDark,
       this.startWidget,
     });
  //NewsLayout x =NewsLayout(
  //);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => ThemeCubit()
        //     ..ChangeAppMode(
        //       fromShared: isDark!,
        //     ),
         ),
        BlocProvider(
            create: (BuildContext context)=> ShopCuit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()
        ),
         BlocProvider(
           create: (BuildContext context) => ShopLoginCuit()..userLogin(),
         ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            ThemeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ) ,
    );
  }
}
