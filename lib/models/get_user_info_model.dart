class GetUserInfoModel {
  FindUser? findUser;

  GetUserInfoModel({this.findUser});

  GetUserInfoModel.fromJson(Map<String, dynamic> json) {
    findUser =
        json['FindUser'] != null ? FindUser.fromJson(json['FindUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findUser != null) {
      data['FindUser'] = findUser!.toJson();
    }
    return data;
  }
}

class FindUser {
  String? sId;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  String? password;
  List<String>? favorites;
  List<String>? bookmarks;
  List<String>? books;
  bool? isAdmin;
  int? iV;

  FindUser({
    this.sId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    this.password,
    this.favorites,
    this.bookmarks,
    this.books,
    this.isAdmin,
    this.iV,
  });

  FindUser.fromJson(Map<String, dynamic> json)
      : sId = json['_id'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        username = json['username'],
        email = json['email'],
        password = json['password'],
        favorites = json['Favorites']?.cast<String>(),
        bookmarks = json['Bookmarks']?.cast<String>(),
        books = json['Books']?.cast<String>(),
        isAdmin = json['isAdmin'],
        iV = json['__v'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['Favorites'] = favorites;
    data['Bookmarks'] = bookmarks;
    data['Books'] = books;
    data['isAdmin'] = isAdmin;
    data['__v'] = iV;
    return data;
  }
}
