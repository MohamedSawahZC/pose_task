import 'package:clinic_mobile/controllers/add_user/states.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/interest_model.dart';

class AddUserCubit extends Cubit<AddUserStates> {
  AddUserCubit() : super(AddUserInitialState());

  static AddUserCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined :  Icons.visibility_off_outlined  ;
    emit(LoginPasswordChangeVisibility());
  }

  List<InterestModel> InterestData=[];
  void getInterestData(){
    emit(GetInterestLoadingState());
        DioHelper.getData(
            url: GETINTEREST,
        ).then((value) => {
          value.data.forEach((e)=>{
            InterestData.add(InterestModel.fromJson(e)),
          }),
          emit(GetInterestSuccessState()),
        }).catchError((error)=>{

          emit(GetInterestErrorState()),
        });
  }

  void AddUser(Username,Password,Email,ImageBase64,InerestId){
    emit(AddUserLoadingState());
    DioHelper.postData(
        url: ADDUSER,
        data: {
        'Username':Username,
          'Password':Password,
          'Email':Email,
          'ImageAsBase64':ImageBase64,
          'IntrestId':InerestId,
        }
    ).then((value) => {
      emit(AddUserSuccessState()),
    }).catchError((error)=>{
      emit(AddUserErrorState()),
    });
  }

}
