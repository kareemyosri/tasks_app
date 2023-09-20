import '../core/enums.dart';

class EmployeeTaskModel {
  String? message;
  List<TaskData>? data;
  bool? status;
  int? code;

  EmployeeTaskModel({this.message, this.data, this.status, this.code});

  EmployeeTaskModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TaskData>[];
      json['data'].forEach((v) {
        data!.add(new TaskData.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}

class TaskData {
  int? id;
  String? name;
  String? description;
  String? photo;
  String? status;
  String? startDate;
  String? endDate;
  Creator? creator;
  Department? department;
  Creator? employee;

  TaskData(
      {this.id,
        this.name,
        this.description,
        this.photo,
        this.status,
        this.startDate,
        this.endDate,
        this.creator,
        this.department,
        this.employee});


  TaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    status = json['status'];
    startDate = json['start date'];
    endDate = json['end date'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    employee = json['employee'] != null
        ? new Creator.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['start date'] = this.startDate;
    data['end date'] = this.endDate;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Creator {
  int? id;
  String? userCode;
  String? name;
  String? email;
  int? phone;
  String? status;
  String? userType;
  int? departmentId;

  Creator(
      {this.id,
        this.userCode,
        this.name,
        this.email,
        this.phone,
        this.status,
        this.userType,
        this.departmentId});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userCode = json['user_code'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    userType = json['user_type'];
    departmentId = json['department_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_code'] = this.userCode;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['department_id'] = this.departmentId;
    return data;
  }
}

class Department {
  int? id;
  String? name;
  Creator? manager;


  Department({this.id, this.name, this.manager});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manager =
    json['manager'] != null ? new Creator.fromJson(json['manager']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.manager != null) {
      data['manager'] = this.manager!.toJson();
    }

    return data;
  }
}
