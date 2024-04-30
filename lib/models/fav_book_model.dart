class favbooks {
  List<Favorites>? favorites;

  favbooks({this.favorites});

  favbooks.fromJson(Map<String, dynamic> json) {
    if (json['favorites'] != null) {
      favorites = <Favorites>[];
      json['favorites'].forEach((v) {
        favorites!.add(new Favorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favorites != null) {
      data['favorites'] = this.favorites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorites {
  Image? image;
  Image? pdf;
  String? sId;
  String? title;
  String? author;
  String? publishDate;
  String? createdAt;
  List<String>? reviews;
  String? description;
  String? category;
  var price;
  bool? topseller;
  bool? onsale;
  bool? upcoming;
  var iV;
  var saleprice;
  double? averageRating;
  bool? newarrival;

  Favorites(
      {this.image,
      this.pdf,
      this.sId,
      this.title,
      this.author,
      this.publishDate,
      this.createdAt,
      this.reviews,
      this.description,
      this.category,
      this.price,
      this.topseller,
      this.onsale,
      this.upcoming,
      this.iV,
      this.saleprice,
      this.averageRating,
      this.newarrival});

  Favorites.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    pdf = json['pdf'] != null ? new Image.fromJson(json['pdf']) : null;
    sId = json['_id'];
    title = json['title'];
    author = json['author'];
    publishDate = json['publishDate'];
    createdAt = json['createdAt'];
    reviews = json['reviews'].cast<String>();
    description = json['description'];
    category = json['category'];
    price = json['price'];
    topseller = json['topseller'];
    onsale = json['onsale'];
    upcoming = json['upcoming'];
    iV = json['__v'];
    saleprice = json['saleprice'];
    averageRating = json['averageRating'];
    newarrival = json['newarrival'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.pdf != null) {
      data['pdf'] = this.pdf!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['publishDate'] = this.publishDate;
    data['createdAt'] = this.createdAt;
    data['reviews'] = this.reviews;
    data['description'] = this.description;
    data['category'] = this.category;
    data['price'] = this.price;
    data['topseller'] = this.topseller;
    data['onsale'] = this.onsale;
    data['upcoming'] = this.upcoming;
    data['__v'] = this.iV;
    data['saleprice'] = this.saleprice;
    data['averageRating'] = this.averageRating;
    data['newarrival'] = this.newarrival;
    return data;
  }
}

class Image {
  String? name;
  String? url;

  Image({this.name, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
