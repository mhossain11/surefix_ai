/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:surefix_ai/helpers/ProjectResource.dart';
import 'package:surefix_ai/utils/api_urls.dart';

class NetworkManager {
  static Future<http.Response> getDataFromApi(
      {required String apiUrl,  String? header,  String? token}) async {
    http.Response response = http.Response("Something went wrong", 500);
    print("API End get: $apiUrl");
    bool internetOn = await ProjectResource.internetConnection();
    print("internet Status");
    print(internetOn);
    if (internetOn) {
      if (kDebugMode) {
        print("Connected");
      }
      try {
        await http
            .get(Uri.parse(apiUrl),
            headers: {
            "Content-Type": "application/json", "Authorization": token!,
            //  'Authorization': 'Bearer 118|qtTBufTzwKH5va62GwoDP7n83q0Bse21DqXx2NEdca41a0fa',
            })
            .timeout(const Duration(seconds: 30))
            .then((val) {
              response = val;
              print("status code Token:${response.statusCode}");
              //print(response.body);
            });
      } catch (e) {
        print(e);
        return response;
      }
    } else {
      print(" Not Connected");
      ProjectResource.showToast("Check internet connection", true);
    }
    return response;
  }

  static Future<http.Response> postDataToApi(
      {required String apiUrl,  String? token, dynamic jsonData}) async {
    http.Response response = http.Response("Something went wrong", 500);
    print("API Endpost : $apiUrl");
    bool internetOn = await ProjectResource.internetConnection();
    print("internet Status: ");
    print(internetOn);
    if (internetOn) {
      print("Connected");
      try {

        await http.post(Uri.parse(ApiEnd.baseUrl + apiUrl),
                headers: {
                 "Content-Type": "application/json"
                },
                body: jsonData)
            .timeout(Duration(seconds: 30))
            .then((val) {
          response = val;


          print("status code Token:${response.statusCode}");
          print(response.body);
        });
      } catch (e) {
        print("error: $e");
        return response;
      }
    } else {
      print("Not Connected");
      ProjectResource.showToast("Check internet connection", true);
    }
    return response;
  }

  static Future<http.Response> putDataToApi(
      {required String apiUrl,  String? token, dynamic jsonData}) async {
    http.Response response = http.Response("Something went wrong", 500);
    print("API End put: " + ApiEnd.baseUrl + apiUrl);
    print("Json: " + jsonData.toString());
    print("Token: " + token.toString());
    bool internetOn = await ProjectResource.internetConnection();
    print("internet Status");
    print(internetOn);
    if (internetOn) {
      print("Connected");
      try {
        await http
            .put(Uri.parse(ApiEnd.baseUrl + apiUrl),
                headers: {
                  "token": token!,
                },
                body: jsonData)
            .timeout(const Duration(seconds: 30))
            .then((val) {
          response = val;
          print("status code Token:${response.statusCode}");
          print(response.body);
        });
      } catch (e) {
        print(e);
        return response;
      }
    } else {
      print(" Not Connected");
      ProjectResource.showToast("Check internet connection", true);
    }
    return response;
  }

  static Future<http.Response> deleteDataToApi(
       {required String apiUrl,  String?  token, dynamic jsonData}) async {
    http.Response response = http.Response("Something went wrong", 500);
    print("API End: " + ApiEnd.baseUrl + apiUrl);
    print("Json: " + jsonData.toString());
    print("Token: " + token.toString());
    bool internetOn = await ProjectResource.internetConnection();
    print("internet Status");
    print(internetOn);
    if (internetOn) {
      print("Connected");
      try {
        await http
            .delete(Uri.parse(ApiEnd.baseUrl + apiUrl),
                headers: {
                  "Accept": "application/json",
                  "token": token!,
                },
                body: jsonData)
            .timeout(Duration(seconds: 30))
            .then((val) {
          response = val;
          print("status code Token:${response.statusCode}");
          print(response.body);
        });
      } catch (e) {
        print(e);
        return response;
      }
    } else {
      print(" Not Connected");
      ProjectResource.showToast("Check internet connection", true);
    }
    return response;
  }
}
