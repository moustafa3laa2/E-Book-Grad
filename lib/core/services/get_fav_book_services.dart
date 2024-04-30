import 'package:bookstore/helper/api.dart';
import 'package:bookstore/helper/local_network.dart';
import 'package:bookstore/models/fav_books_model.dart';

class GetFavBooksServices {
  Future<List<FavBooksModel>> getFavBooks() async {
    Map<String, dynamic> data = await Api().get(
      url: 'https://book-store-api-mu.vercel.app/User/Favorites',
      token: CacheNetwork.getCacheData(key: 'token'),
    );
    List<FavBooksModel> favBooksList = [];
    for (int i = 0; i < data.length; i++) {
      favBooksList.add(
        FavBooksModel.fromJson(data[i]),
      );
    }
    return favBooksList;
  }
}
