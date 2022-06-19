// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;




class ContractService {
  Future<String> getContract() async {
    // Map<String,dynamic> jsonMap = <String, dynamic>
    // {
    //   "rider_id": riderID
    // };
    final response = await http.get(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/dj_agreement"),
    );
    print("I am receiving Response of URL http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/dj_agreement ${response.body} ");
    print("Status Code ${response.statusCode}");
    
    if (response.statusCode == 200) {
      var responseMusicGenre = jsonDecode(response.body);
      if(responseMusicGenre['status'] == 0 )
      {
        return "";
      }
      else
      {
        return responseMusicGenre['agreement'][0]['agreement'];
      // List<MusicGenreModal> genre = _musicGenreFromJson(response.body);
      // return genre;
      }
    } else {
      return "";
    }
  }

  Future<String> acceptContract(String djID) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djID,
      "agreement_status" : "1"
    };
    final response = await http.post(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/dj_agreement_status_on"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Agreement Accept Api =>  ${response.body} ");
    print("Status Code ${response.statusCode}");
    
    if (response.statusCode == 201) {
      var responseAcceptAgreement = jsonDecode(response.body);
      return responseAcceptAgreement['message'];
    } else {
      return "error";
    }
  }

  Future<String> checkContractStatus(String djID) async {
    Map<String,dynamic> jsonMap = <String, dynamic>
    {
      "id": djID,
    };
    final response = await http.post(
      Uri.parse("http://kaspar.eastus.cloudapp.azure.com/jynx_club/api/dj_agreement_status_check"),
      body: jsonEncode(jsonMap)
    );
    print("I am receiving Response of Status Check Agreement Accept Api =>  ${response.body} ");
    print("Status Code ${response.statusCode}");
    
    if (response.statusCode == 200) {
      var responseStatusAgreement = jsonDecode(response.body);
      if(responseStatusAgreement['status'] == "1"){

        if (responseStatusAgreement['agreement_status'].toString() == "1")
        {
          return "true";
        }
        else{
          return "false";
        }

      }
      else {
        return "error";
      }
    } else {
      return "error";
    }
  }

}
