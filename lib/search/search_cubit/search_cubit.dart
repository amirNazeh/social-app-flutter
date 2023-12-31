import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/network/end_points.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/search/search_cubit/search_states.dart';
import 'package:shopapp/shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? model;
  void search(String text){
    emit(SearchLodingState());

    DioHelper.postData(
        url: SEARCH,
        token :token,
        data: {
          'text':text,
        },
        ).then((value) {
          model = SearchModel.fromJson(value.data);

          emit(SearchSuccesState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}