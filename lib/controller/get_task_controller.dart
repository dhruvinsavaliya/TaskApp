import 'dart:developer';

import 'package:api_prec/api/model/res_model/taskapp_res_model.dart';
import 'package:api_prec/api/repo/get_all_task_repo.dart';
import 'package:flutter/material.dart';

class GetTaskController extends ChangeNotifier {
  List<TaskappResModel>? model;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void getTaskData() {
    try {
      dynamic res = GetAllTaskRepo.getAllTaskRepo();
      model = res;
      _isLoading = false;
    } catch (e) {
      log('Error $e');
    }

    notifyListeners();
  }
}
