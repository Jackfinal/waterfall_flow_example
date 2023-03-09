///
/// @Author: jack
/// @Date: 2/6/23 7:38 PM
/// @Email: final_m@foxmail.com
///
class Global {
  static String defautlImageUrl = 'https://wanjia-zhuokearts.oss-cn-beijing.aliyuncs.com/appstatic/images/defaultImage.jpg?v=1';

  static String version = '';

  //判断是否显示默认图片
  static String getImageUrl(url, {double width =0}){
    String query = '?';
    if(width>0){
      int w = width.toInt();
      query += 'x-oss-process=image/resize,w_$w';
    }
    if (url == '' || url == null) {
      return defautlImageUrl;
    } else {
      return url + query;
    }
  }
  // 去除oss参数
  static String removeImageUrlOss(String url){
    return url.split('?')[0];
  }

}