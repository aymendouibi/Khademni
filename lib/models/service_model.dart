
class serviceModel {
String title,userID,desc,id;
List image;
int views;
serviceModel({this.title,this.image});
serviceModel.fromJson(Map<String, dynamic> map){
  title = map['title'];
  image = map['image'];
  desc = map['desc'];
  userID = map['userID'];
  views = map['views'];
  id = map['id'];
}

toJson(){
  return {
    'title':title,
  'image':image,
  'desc':desc,
  'userID':userID,
  'views':views,
  'id':id,
  };
}
}