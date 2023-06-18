class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String , dynamic >json)
  {
    status = json['status'];
    data= HomeDataModel.fromjson(json['data']);
  }

}

class HomeDataModel
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  HomeDataModel.fromjson(Map<String , dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromjson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromjson(element));
    });
  }
}

class BannerModel
{
  int? id;
  String? image;
  BannerModel.fromjson(Map<String , dynamic>json)
  {
   id = json['id'];
   image = json['image'];
  }
}

class ProductModel
{
  int? id;
  dynamic? price;
  dynamic? oldprice;
  dynamic? discound;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;


  ProductModel.fromjson(Map<String , dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldprice = json['old_price'];
    discound = json['discound'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}