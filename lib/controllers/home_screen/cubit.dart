import 'package:clinic_mobile/controllers/home_screen/states.dart';
import 'package:clinic_mobile/controllers/option/cubit.dart';
import 'package:clinic_mobile/models/note.dart';
import 'package:clinic_mobile/shared/network/cache_helper.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/shared/network/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/user_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<NoteModel> notes = [];
  List<NoteModel> search = [];
  List<NoteModel> filter = [];
  List<UserModel> users=[];
  late Database database;

  void getAllUsers(){
    emit(GetUsersLoadingState());
    DioHelper.getData(
        url: ALLUSERS
    ).then((value) => {
      value.data.forEach((e)=>{
        users.add(UserModel.fromJson(e)),

      }),
      emit(GetUsersSuccessState()),
    }).catchError((error){
      print(error);
      emit(GetUsersErrorState());

    });

  }
  void getAllNotes() async{
    notes=[];
    emit(HomeDataLoadingState());
    await DioHelper.getData(
      url: GETNOTES,
    )
        .then((value) => {
         value.data.forEach((e)=>{

                notes.add(NoteModel.fromJson(e)),
              }),


      InsertNotesToLocal(),
      emit(HomeDataSuccessState()),

    })
        .catchError((error)  {
            print(error);
              bool val = CasheHelper.getData(key: 'switch') ?? false;
              if(val) {
                GetNotes(database);
              }else{
                emit(HomeDataErrorState());
              }
            });
  }

  bool DisplaySearch = false;
  bool DisplayFilter = false;
  void ShowSearch (){
    DisplaySearch = !DisplaySearch;
    emit(DisplaySearchState());
  }
  void ShowFilter (){
    DisplayFilter = !DisplayFilter;
    emit(DisplayFilterState());
  }

  void searchByText(String text){
    search =[];
    notes.forEach((element) {
      if(element.text.contains(text)){
        search.add(element);
      }
      emit(SearchByTextState());
    });

  }

  void filterByUser(String userId){
    filter =[];
    notes.forEach((element) {
      if(element.userId==userId){
        filter.add(element);
      }
    });
    print(filter.length);
    emit(FilterByUserState());
  }

  void createDatabase() {
    openDatabase(
      'notes.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
            'CREATE TABLE Note(id INTEGER PRIMARY KEY, text TEXT, placeDateTime TEXT, userId TEXT, noteId TEXT)')
            .then(
              (value) => print('Table created'),
        )
            .catchError((err) => print("err${err.toString()}"));
      },

      onOpen: (database) {
        getAllNotes();
      },
    ).then((value) => {
      database = value,
      emit(CreateDatabaseState()),
    });
  }
  void InsertNotesToLocal() async{
    await database.execute("DROP TABLE IF EXISTS Note").then((value) => print('Droped + ==========='));
    database
        .execute(
        'CREATE TABLE Note(id INTEGER PRIMARY KEY, text TEXT, placeDateTime TEXT, userId TEXT, noteId TEXT)')
        .then(
          (value) => print('Table created'+ "======================"),
    )
        .catchError((err) => print("err${err.toString()}"));
    notes.forEach((element) async{
      await database.transaction((txn) async {
        txn
            .rawInsert(
            'INSERT INTO Note(text,placeDateTime,userId,noteId) VALUES("${element.text}","${element.placeDateTime}","${element.userId}","${element.id}")')
            .then((value) => {
              print("Sawahhhhhhhhhhh"),
          emit(HomeDataSuccessState()),
        })
            .catchError((error) {
          print('Error : ${error.toString()}');
        });
        return null;
      });
    });

  }

  void GetNotes(database) async{
    notes = [];
    await database.execute("DROP TABLE IF EXISTS Note").then((value) => print('Droped + ==========='));
    database
        .execute(
        'CREATE TABLE Note(id INTEGER PRIMARY KEY, text TEXT, placeDateTime TEXT, userId TEXT, noteId TEXT)')
        .then(
          (value) => print('Table created'+ "======================"),
    )
        .catchError((err) => print("err${err.toString()}"));
    database.rawQuery('SELECT * FROM Note').then((value) => {
      value.forEach((element) {
        notes.add(NoteModel.fromJson(element));
      }),
    });
    emit(LocalDataSuccessState());
  }

}
