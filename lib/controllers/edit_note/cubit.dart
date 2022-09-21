import 'package:clinic_mobile/controllers/edit_note/states.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

class EditNoteCubit extends Cubit<EditNoteStates> {
  EditNoteCubit() : super(EditNoteInitialStates());

  static EditNoteCubit get(context) => BlocProvider.of(context);
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

  void updateNoteData(text,id,userId){
    emit(UpdateNoteLoadingState());
    DioHelper.postData(
        url: UPDATENOTE,
        data: {
          'Id':id,
          'Text':text,
          'UserId':userId,
        },

    ).then((value)=>{
      emit(UpdateNoteSuccessState()),
    }).catchError((error)=>{
      emit(UpdateNoteErrorState()),
      print((error))
    });

  }



}
