// get values from addto_cart_items.dart. (From  cart screen)
class ProductModel {
  // we need these when user send order requests to server.(Seller).
  final String url;
  final String productName;
  // final String productDescription; willbe using later.
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;

  ProductModel(this.url, this.productName, this.cost, this.discount, this.uid,
      this.sellerName, this.sellerUid, this.rating, this.noOfRating);

  Map<String, dynamic> getJson() {
    return {
      "url": url,
      "productName": productName,
      "cost": cost,
      "discount": discount,
      "uid": uid,
      "sellerName": sellerName,
      "sellerUid": sellerUid,
      "rating": rating,
      "noOfRating": noOfRating,
    };
  }

  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    // return ProductModel(url, productName, cost, discount, uid, sellerName, sellerUid, rating, noOfRating)
    return ProductModel(
        json["url"],
        json["productName"],
        json["cost"],
        json["discount"],
        json["uid"],
        json["sellerName"],
        json["sellerUid"],
        json["rating"],
        json["noOfRating"]);
  }
}
