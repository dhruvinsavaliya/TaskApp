import 'package:api_prec/api/api_handler/api_handler.dart';
import 'package:api_prec/api/routes/base_services.dart';
import 'package:api_prec/utils/Shared_prefutils.dart';
import 'package:api_prec/utils/enum_utils.dart';
import 'package:http/http.dart' as http;

class UpdateTask {
  static Future updtetaskrepo(
      {required Map<String, dynamic>? reqbody, String? id}) async {
    Map<String, String> header = {"x-access-token": SharedPrefutils.getToken()};

    String updateurl = BaseServiceRoute.updateTaskURL;
    var response = await APIHandler.apiHandler(
        url: updateurl + id!,
        apiType: APIType.aPut,
        header: header,
        reqBody: reqbody);

    return response;
  }
}
