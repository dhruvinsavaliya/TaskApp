import 'dart:developer';
import 'package:api_prec/api/api_handler/api_handler.dart';
import 'package:api_prec/api/routes/base_services.dart';
import 'package:api_prec/utils/Shared_prefutils.dart';
import 'package:api_prec/utils/enum_utils.dart';

class CreateTask {
  static Future createtaskrepo({required Map<String, dynamic>? reqbody}) async {
    Map<String, String> header = {"x-access-token": SharedPrefutils.getToken()};
    log("======>$reqbody");

    var response = await APIHandler.apiHandler(
        url: BaseServiceRoute.createTaskURL,
        apiType: APIType.aPost,
        header: header,
        reqBody: reqbody);

    return response;
  }
}
