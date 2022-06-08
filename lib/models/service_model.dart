

class serviceModel {
String title,userID,desc,id,category,type;
List image;
int views;
double price;
serviceModel({this.title,this.image,this.category,this.desc,this.id,this.price,this.userID,this.views});
serviceModel.fromJson(Map<String, dynamic> map){
  title = map['title'];
  image = map['image'];
  desc = map['desc'];
  userID = map['userID'];
  views = map['views'];
  id = map['id'];
  category = map['category'];
  price = map['price'];
  type = map['type'];
}

toJson(){
  return {
    'title':title,
  'image':image,
  'desc':desc,
  'userID':userID,
  'views':views,
  'id':id,
  'category':category,
  'price':price,
  'type':type,
  };
}

}