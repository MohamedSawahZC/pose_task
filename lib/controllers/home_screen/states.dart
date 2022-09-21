
abstract class HomeStates {}

class HomeInitialStates extends HomeStates {}
class HomeDataLoadingState extends HomeStates {}
class HomeDataSuccessState extends HomeStates {}
class HomeDataErrorState extends HomeStates {}
class DisplaySearchState extends HomeStates {}
class DisplayFilterState extends HomeStates {}
class SearchByTextState extends HomeStates{}
class FilterByUserState extends HomeStates{}


class GetUsersLoadingState extends HomeStates {}
class GetUsersSuccessState extends HomeStates {}
class GetUsersErrorState extends HomeStates {}

class CreateDatabaseState extends HomeStates {}
class GetNotesFromDatabase extends HomeStates {}
class InsertIntoDatabaseState extends HomeStates {}
class SetNotesLoadingState extends HomeStates{}
class SetNotesSuccessState extends HomeStates{}
class LocalDataSuccessState extends HomeStates{}