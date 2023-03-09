import './art_pic.dart';
import '../global.dart';
class Art {
  Art({
    required this.id,
    required this.title,
    required this.type,
    required this.typeName,
    required this.sizeW,
    required this.sizeH,
    required this.generalPrice,
    required this.recommendPrice,
    required this.percentage,
    required this.createDate,
    required this.description,
    required this.videoUrl,
    required this.content,
    required this.thumb,});

  Art.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    videoUrl = json['video_url'];
    typeName = json['type_name'];
    sizeW = json['size_w'];
    sizeH = json['size_h'];
    generalPrice = json['general_price']/100;
    recommendPrice = json['recommend_price']/100;
    percentage = json['percentage']/100;
    createDate = json['create_date'];
    description = json['description'];
    content = json['content']??'';
    if(json['thumb'] != '' && json['thumb'] is Map) {
      thumb = ArtPic.fromMap(json['thumb']);
    }else if(json['thumb'] != '' && json['thumb'] is ArtPic){
      thumb = json['thumb'];
    }
  }
  Art.fromMap(Map json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    videoUrl = json['video_url'];
    typeName = json['type_name'];
    sizeW = json['size_w'];
    sizeH = json['size_h'];
    generalPrice = json['general_price']/100;
    recommendPrice = json['recommend_price']/100;
    percentage = json['percentage']/100;
    createDate = json['create_date'];
    description = json['description'];
    content = json['content']??'';
    if(json['thumb'] != '') thumb = ArtPic.fromMap(json['thumb']);
  }
  int id = 0;
  String title = '';
  int type = 0;
  String typeName = '';
  String videoUrl = '';
  int sizeW = 0;
  int sizeH = 0;
  double generalPrice = 0;
  double recommendPrice = 0;
  double percentage = 0;
  String createDate = '';
  String description = '';
  String content = '';
  ArtPic thumb = ArtPic(id: 0, artId: 0, listorder: 0, type: 0, url: Global.defautlImageUrl, cardboardId: 0, frameId: 0);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['type_name'] = typeName;
    map['video_url'] = videoUrl;
    map['size_w'] = sizeW;
    map['size_h'] = sizeH;
    map['general_price'] = generalPrice;
    map['recommend_price'] = recommendPrice;
    map['percentage'] = percentage;
    map['create_date'] = createDate;
    map['description'] = description;
    map['content'] = content;
    map['thumb'] = thumb;
    return map;
  }

}