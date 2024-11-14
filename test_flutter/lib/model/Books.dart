class Books {
  String? id;
  String? title;
  String? author;
  int? price;
  int? originalPrice;
  String? image;
  String? stock;
  String? category;

  Books(
      {this.id,
        this.title,
        this.author,
        this.price,
        this.originalPrice,
        this.image,
        this.stock,
        this.category});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    image = json['image'];
    stock = json['stock'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['category'] = this.category;
    return data;
  }
}