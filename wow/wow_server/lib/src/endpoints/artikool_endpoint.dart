import 'package:serverpod/serverpod.dart';
import 'package:wow_server/src/generated/protocol.dart';

class ArtikoolEndpoint extends Endpoint {
  //Fetch articles from DB
  Future<List<Article?>> getArticles(Session session,
      {String? keywoardTitle, String? keywoardContent}) async {
    List<Article>? result;

    if (keywoardTitle != null) {
      result = await Article.find(session,
          where: (t) => t.title.like('%$keywoardTitle%'));
      return result;
    } else if (keywoardContent != null) {
      result = await Article.find(session,
          where: (t) => t.content.like('%$keywoardContent%'));
      return result;
    } else
      return result = await Article.find(session, where: (t) => Constant(true));
  }

  //add artice to db
  Future<bool> addArticle(Session session, Article article) async {
    await Article.insert(session, article);
    return true;
  }

  //get total amount of articles
  Future<int> getArticlesTotalAmont(Session session) async {
    final result = await Article.find(session, where: (t) => Constant(true));
    return result.length;
  }

  Future<bool> editArticle(Session session, Article article) async {
    var result = await Article.update(session, article);
    return result;
  }

  Future<bool> deleteArticle(Session session, int id) async {
    var result = await Article.delete(session, where: (t) => t.id.equals(id));
    return result == 1;
  }

  //Fetch Weather Info
  Future<WeatherInfo> getWeatherInfo(Session session, int cityId) async {
    var weatherKey = 'weather-$cityId';

    var weatherInfo =
        await session.caches.local.get(weatherKey) as WeatherInfo?;
    if (weatherInfo == null) {
      await Future.delayed(Duration(seconds: 1));
      weatherInfo = WeatherInfo(temperature: 24);
      await session.caches.local
          .put(weatherKey, weatherInfo, lifetime: Duration(minutes: 2));
          print('putted to cache');
    }
    return weatherInfo;
  }


Future<String> getString(Session session) async {
 dynamic result = await session.caches.local.get('weather-33');
  if (result != null) {
    return 'HAVE CACHED DATA';
  } else
    return 'NO CAHCE';
}
}