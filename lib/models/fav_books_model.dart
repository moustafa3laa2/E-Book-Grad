class FavBooksModel {
  final ImageModel image;
  final PdfModel pdf;
  final String id;
  final String title;
  final String author;
  final String publishDate;
  final String createdAt;
  final List reviews;
  final String description;
  final String category;
  final int price;
  final bool topseller;
  final bool onsale;
  final bool upcoming;
  final int v;
  final int saleprice;
  final double averageRating;
  final bool newarrival;

  FavBooksModel({
    required this.image,
    required this.pdf,
    required this.id,
    required this.title,
    required this.author,
    required this.publishDate,
    required this.createdAt,
    required this.reviews,
    required this.description,
    required this.category,
    required this.price,
    required this.topseller,
    required this.onsale,
    required this.upcoming,
    required this.v,
    required this.saleprice,
    required this.averageRating,
    required this.newarrival,
  });
  factory FavBooksModel.fromJson(jsonData) {
    return FavBooksModel(
      image: ImageModel.fromJson(jsonData['image']),
      pdf: PdfModel.fromJson(jsonData['pdf']),
      id: jsonData["_id"],
      title: jsonData['title'],
      author: jsonData['author'],
      publishDate: jsonData['publishDate'],
      createdAt: jsonData['createdAt'],
      reviews: jsonData['reviews'],
      description: jsonData['description'],
      category: jsonData['category'],
      price: jsonData['price'],
      topseller: jsonData['topseller'],
      onsale: jsonData['onsale'],
      upcoming: jsonData['upcoming'],
      v: jsonData['__v'],
      saleprice: jsonData['saleprice'],
      averageRating: jsonData['averageRating'],
      newarrival: jsonData['newarrival'],
    );
  }
}

class ImageModel {
  final String name;
  final String url;

  ImageModel({required this.name, required this.url});
  factory ImageModel.fromJson(jsonData) {
    return ImageModel(name: jsonData['name'], url: jsonData['url']);
  }
}

class PdfModel {
  final String name;
  final String url;

  PdfModel({required this.name, required this.url});
  factory PdfModel.fromJson(jsonData) {
    return PdfModel(name: jsonData['name'], url: jsonData['url']);
  }
}
