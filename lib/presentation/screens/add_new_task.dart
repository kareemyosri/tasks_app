import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks_app/bussiness_logic/add_new_task/addtask_cubit.dart';

import '../../core/constants.dart';
import '../styles.dart';
import '../widgets/ElvatedButton.dart';
import '../widgets/TextFormField.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController employeeIDController = TextEditingController();
  late AddtaskCubit cubit;
  late String date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = AddtaskCubit.get(context);
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate$endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddtaskCubit, AddtaskState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CreateTaskSuccessfullyState) {
          print("Task Created Successfully");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task Created Successfully')),
          );
        } else if (state is CreateTaskErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed To Create...  ')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Add New Task!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: AppTheme.primaryColor,
                            fontSize: 28.5.sp, //34
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text(
                          'Create a new task now and assign it to employees right away.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: AppTheme.greyColor,
                            fontSize: 13.5.sp, //34
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _buildDefaultRangeDatePickerWithValue(),

                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                        validator: (value) {},
                        controller: titleController,
                        hintText: 'Title',
                        obscureText: false),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                        maxLines: 4,
                        validator: (value) {},
                        controller: descriptionController,
                        hintText: 'Description',
                        obscureText: false),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocBuilder<AddtaskCubit, AddtaskState>(
                      builder: (context, state) {
                        return DropdownButtonFormField(
                          items: cubit.employees
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.email,
                                    child: Text(item.email??""),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            cubit.getIdValue(newValue);
                          },
                        );
                      },
                    ),
                    // CustomTextFormField(
                    //     validator: (value) {},
                    //     controller: employeeIDController,
                    //     hintText: 'Assigned Employee',
                    //     obscureText: false),
                    SizedBox(
                      height: 10.h,
                    ),

                    // BlocBuilder<UserCubit, UserState>(
                    //   builder: (context, state) {
                    //     return Visibility(
                    //       visible: state is CreateUserLoadingState,
                    //       child: Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 1.h,
                    //           ),
                    //           const Center(
                    //             child: CircularProgressIndicator(
                    //               color: AppTheme.primaryColor,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(() {
                        List fullDate = date.split(" ");
                        print(fullDate[0]);
                        print(fullDate[1]);
                        cubit.createTask(
                            title: titleController.text,
                            description: descriptionController.text,
                            employeeId:   selectedValue.toString(),
                            startDate: fullDate[0],
                            endDate: fullDate[1]);
                      }, 'CREATE'),
                      BlocBuilder<AddtaskCubit, AddtaskState>(
                        builder: (context, state) {
                          return Visibility(
                              visible: state is CreateTaskLoadingState,
                              child: const Center(
                                  child: CircularProgressIndicator()));
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppTheme.primaryColor2,
      weekdayLabelTextStyle: const TextStyle(
        color: AppTheme.greyColor,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // const SizedBox(height: 10),
        // const Text('Range Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          value: cubit.rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) => cubit.changeDate(dates),
        ),

        BlocBuilder<AddtaskCubit, AddtaskState>(
          builder: (context, state) {
            date = _getValueText(
              config.calendarType,
              cubit.rangeDatePickerValueWithDefaultValue,
            );
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Selection(s): '),
                const SizedBox(width: 10),
                Text(date),
              ],
            );
          },
        ),
      ],
    );
  }
}
