import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
 static TaskCubit get(context)=> BlocProvider.of(context);

  int buttonValue = 0;

  changeTaskStatus(value) {
    buttonValue = value;
    emit(ChangeTaskStatusState());
  }


}
