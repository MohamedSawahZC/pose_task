
abstract class AddNoteStates {}

class AddNoteInitialStates extends AddNoteStates {}

class GetAllUsersLoadingState extends AddNoteStates {}
class GetAllUsersSuccessState extends AddNoteStates {}
class GetAllUsersErrorState extends AddNoteStates {}

class AddNoteLoadingState extends AddNoteStates {}
class AddNoteSuccessState extends AddNoteStates {}
class AddNoteErrorState extends AddNoteStates {}