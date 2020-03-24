class ShopModel {
  String id;
  String name;
  String prize;
  String thumb;
  String video;
  String gif;
  String url;

  static List<ShopModel> fromMapList(List list) {
    var ls = List<ShopModel>();
    list.forEach((m) {
      ls.add(ShopModel.fromMap(m));
    });
    return ls;
  }

  ShopModel.fromMap(Map json) {
    id = json['id'];
    name = json['name'];
    prize = json['prize'];
    thumb = json['thumb'];
    video = json['video'];
    gif = json['gif'];
    url = json['url'];
  }
}
