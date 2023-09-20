import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../bussiness_logic/task/task_cubit.dart';
import '../../styles.dart';
import '../../widgets/task_view.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late TaskCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit=TaskCubit.get(context);
    //cubit.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>
                        TaskView(taskData: cubit.employeeTasks[index]),
                    separatorBuilder: (context,index)=>SizedBox(height: 2.h,),
                    itemCount: cubit.employeeTasks.length);
              },
            ),
            SizedBox(height: 10.h,)
          ],
        ),
      ),
    );
  }
}
