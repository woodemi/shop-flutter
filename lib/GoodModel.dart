class ShopModel {
  String gid;
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
    gid = json['gid'];
    name = json['name'];
    prize = json['prize'];
    thumb = json['thumb'];
    video = json['video'];
    gif = json['gif'];
    url = json['url'];
  }
}
