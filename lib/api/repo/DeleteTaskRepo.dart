import 'package:api_prec/api/api_handler/api_handler.dart';
import 'package:api_prec/api/routes/base_services.dart';
import 'package:api_prec/utils/Shared_prefutils.dart';
import 'package:api_prec/utils/enum_utils.dart';
import 'package:http/http.dart' as http;

class DeleteTask {
  static Future deletetaskrepo({String? id})async {
    Map<String, String> header = {
      "x-access-token": SharedPrefutils.getToken()
    };


    var response =await  APIHandler.apiHandler(url: BaseServiceRoute.deleteTaskURL ,
        apiType: APIType.aDelete,
        header: header,
    );

    if(response.statusCode == 200){}

  }
}