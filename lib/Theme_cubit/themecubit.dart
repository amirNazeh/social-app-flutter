import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Theme_cubit/theme_state.dart';
import 'package:shopapp/network/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeState>
{
  ThemeCubit(): super(NewssInitialState());
  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void ChangeAppMode({required bool fromShared}){
    isDark =! isDark;
    emit(NewssAppChangeModeState());

    void changeAppMode({required bool fromShared})
    {
      if (fromShared != null)
      {
        isDark = fromShared;
        emit(AppChangeModeState());
      } else
      {
        isDark = !isDark;
        CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
          emit(AppChangeModeState());
        });
      }
    }

  }



}
