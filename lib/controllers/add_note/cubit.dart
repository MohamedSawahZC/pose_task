import 'package:clinic_mobile/controllers/add_note/states.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class AddNoteCubit extends Cubit<AddNoteStates> {
  AddNoteCubit() : super(AddNoteInitialStates());

  static AddNoteCubit get(context) => BlocProvider.of(context);
  List<UserModel> users=[];
  void getAllUsers(){
    emit(GetAllUsersLoadingState());
    DioHelper.getData(
        url: ALLUSERS
    ).then((value) => {
      value.data.forEach((e)=>{
        users.add(UserModel.fromJson(e)),

      }),
      emit(GetAllUsersSuccessState()),
    }).catchError((error){
      print(error);
      emit(GetAllUsersErrorState());

    });

  }

  void InsertNote(text,userId,dateTime,context){
    emit(AddNoteLoadingState());
    DioHelper.postData(
        url: ADDNOTE,
        data: {
          'Text':text,
          'UserId':userId,
          'PlaceDateTime':dateTime,
    }).then((value) => {
      HomeCubit.get(context).getAllNotes(),
      emit(AddNoteSuccessState()),
    }).catchError((error)=>{
      print(error),
      emit(AddNoteErrorState()),
    });
  }

}
