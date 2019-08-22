class PlaceItemRes {
  String name;
  String address;
  double lat, lng;
  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json){
    print("parse data");
    List<PlaceItemRes> rs = new List();
    //print("hello world");
    var results = json['results'] as List;
    print("aa" + results.toString());
    for(var item in results){
      var p = new PlaceItemRes(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);
        print(item['name']);
      rs.add(p);
    }
    return rs;
  }
}