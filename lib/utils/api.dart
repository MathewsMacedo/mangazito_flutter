import 'package:http/http.dart' as http;
import 'package:manga_app/utils/constants.dart';

class Api {
  final String _url = 'https://mangazito.fly.dev/api/public/v1/manga';

  getAllMangaListPerPage(int page, int order) async {
    http.Response response =
        await http.get(Uri.parse(_url + "/all?page=${page}&order=${order}"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getSarchMangaListPerPage(String search, int page, int order) async {
    http.Response response = await http.get(
        Uri.parse(_url + "/search?name=${search}&page=${page}&order=${order}"));
    try {
      return response;
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getUserDetail(String token) async {
    http.Response response = await http.get(Uri.parse(
        "https://mangazito.fly.dev/api/public/v1/user/show/${token}"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getFavoriteMangaListPerPage(String token) async {
    http.Response response = await http.get(Uri.parse(
        "https://mangazito.fly.dev/api/public/v1/manga/favorites?token=${token}"));
    try {
      return response;
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getAllCategoriesMangaListPerPage(int page, String category, int order) async {
    http.Response response = await http.get(Uri.parse(
        _url + "/categories/${category}?page=${page}&order=${order}"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  postFavoriteMangaList(String token, int idSerie) async {
    http.Response response = await http.post(Uri.parse(
        "https://mangazito.fly.dev/api/public/v1/manga/favorites?token=${token}&id_serie=${idSerie}"));
    try {
      return response;
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  postUserManga(String user, String password, String avatar) async {
    http.Response response = await http.post(Uri.parse(
        "https://mangazito.fly.dev/api/public/v1/user/create?username=${user}&password=${password}&avatar=${avatar}"));
    try {
      return response;
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  postUserLogin(String user, String password) async {
    http.Response response = await http.post(Uri.parse(
        "https://mangazito.fly.dev/api/public/v1/user/login?username=${user}&password=${password}"));
    try {
      return response;
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getMangaDetails(int mangaId) async {
    http.Response response =
        await http.get(Uri.parse(_url + "/details/${mangaId}?token=${token}"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getImagesManga(int mangaId, int chapterId, int idLink) async {
    http.Response response = await http.get(Uri.parse(
        _url + "/details/${mangaId}/${idLink}?id_chapter=${chapterId}"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  getAllCategories() async {
    http.Response response = await http.get(Uri.parse(_url + "/categories"));
    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      print(e);
      return 'failed';
    }
  }
}
