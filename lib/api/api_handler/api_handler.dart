import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/enum_utils.dart';
import '../routes/base_services.dart';

class APIHandler {
  static http.Response? response;

  static Future apiHandler({required String url,
    required APIType apiType,
    Map<String, dynamic>? reqBody,
    Map<String, String>? header}) async {
    String path = BaseServiceRoute.baseURL + url;

    try {
      if (apiType == APIType.aGet) {
        /// ==============GET=================
        response = await http.get(Uri.parse(path), headers: header);
        if (response!.statusCode == 200) {
          return response!.body;
        } else {
          return null;
        }
      } else if (apiType == APIType.aPost) {
        /// ==============POST=================
        response =
        await http.post(Uri.parse(path), headers: header, body: reqBody);

        if (response!.statusCode == 200) {
          return "task created";
        } else {
          return "not";
        }
      } else if (apiType == APIType.aPut) {
        /// ==============PUT=================
        response =
        await http.put(Uri.parse(path), headers: header, body: reqBody);
        if (response!.statusCode == 200) {
          return "task updated";
        } else {
          return "not";
        }
      } else {
        /// ==============DELETE=================
        response =
        await http.delete(Uri.parse(path), headers: header, body: reqBody);
        if (response!.statusCode == 200) {
          return response!.body;
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }
}
