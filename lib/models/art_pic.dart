class ArtPic {
  ArtPic({
    required this.id,
    required this.artId,
    required this.type,
    required this.url,
    required this.cardboardId,
    required this.frameId,
    required this.listorder,});

  ArtPic.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    artId = map['art_id'];
    type = map['type'];
    url = map['url'];
    cardboardId = map['cardboard_id'];
    frameId = map['frame_id'];
    listorder = map['listorder'];
  }
  ArtPic.fromJson(dynamic json) {
    id = json['id'];
    artId = json['art_id'];
    type = json['type'];
    url = json['url'];
    cardboardId = json['cardboard_id'];
    frameId = json['frame_id'];
    listorder = json['listorder'];
  }
  int id = 0;
  int artId = 0;
  int type = 0;
  int cardboardId = 0;
  int frameId = 0;
  String url = '';
  int listorder = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['art_id'] = artId;
    map['type'] = type;
    map['frame_id'] = frameId;
    map['cardboard_id'] = cardboardId;
    map['url'] = url;
    map['listorder'] = listorder;
    return map;
  }

}