import 'dart:convert';
import 'dart:developer';
import 'package:api_prec/utils/Shared_prefutils.dart';
import '../../utils/enum_utils.dart';
import '../api_handler/api_handler.dart';
import '../model/res_model/taskapp_res_model.dart';
import '../routes/base_services.dart';

class GetAllTaskRepo {
  static Future<List<TaskappResModel>> getAllTaskRepo() async {
    Map<String, String> headers = {
      'x-access-token': SharedPrefutils.getToken()
    };

    var response = await APIHandler.apiHandler(
        url: BaseServiceRoute.getAllTaskURL,
        apiType: APIType.aGet,
        header: headers);

    List<TaskappResModel> res = List<TaskappResModel>.from(
        json.decode(response).map((e) => TaskappResModel.fromJson(e)));

    return res;
  }
}
