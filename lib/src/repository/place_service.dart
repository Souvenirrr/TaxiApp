import 'dart:async';
import 'package:taxi_app/src/model/place_item_res.dart';
import 'package:taxi_app/src/config/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService{
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    //Configs configs = new Configs();
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
        "AIzaSyDVB0jTF7R2g1haWlKKRzbbJbi9Xc9_t0Q" +
        "&language=vi&region=VN&query=" +
        Uri.encodeQueryComponent(keyword);
    
    print("search >>: " + url);
    var res = await http.get(url);
    if(res.statusCode == 200){
      return PlaceItemRes.fromJson(json.decode(res.body));
    }else{
      return new List();
    }
  }
}
