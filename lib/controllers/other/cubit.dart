import 'package:clinic_mobile/controllers/add_note/states.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/controllers/other/states.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class OtherCubit extends Cubit<OtherStates> {
  OtherCubit() : super(OtherInitialStates());

  static OtherCubit get(context) => BlocProvider.of(context);


  void clearNotes(){
    emit(ClearLoadingState());
    DioHelper.postData(
        url: CLEARNOTES,
    ).then((value)  {
      emit(ClearSuccessState());
    }).catchError((error){
      emit(ClearErrorState());
    });
  }
  void resetDummy(){
    emit(ResetLoadingState());
    DioHelper.postData(
      url: RESETDUMMY,
    ).then((value)  {
      emit(ResetSuccessState());
    }).catchError((error){
      emit(ResetErrorState());
    });
  }

}
