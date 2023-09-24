/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:wow_client/src/protocol/article.dart' as _i3;
import 'package:wow_client/src/protocol/weather_model.dart' as _i4;
import 'dart:io' as _i5;
import 'protocol.dart' as _i6;

class _EndpointArtikool extends _i1.EndpointRef {
  _EndpointArtikool(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'artikool';

  _i2.Future<List<_i3.Article?>> getArticles({
    String? keywoardTitle,
    String? keywoardContent,
  }) =>
      caller.callServerEndpoint<List<_i3.Article?>>(
        'artikool',
        'getArticles',
        {
          'keywoardTitle': keywoardTitle,
          'keywoardContent': keywoardContent,
        },
      );

  _i2.Future<bool> addArticle(_i3.Article article) =>
      caller.callServerEndpoint<bool>(
        'artikool',
        'addArticle',
        {'article': article},
      );

  _i2.Future<int> getArticlesTotalAmont() => caller.callServerEndpoint<int>(
        'artikool',
        'getArticlesTotalAmont',
        {},
      );

  _i2.Future<bool> editArticle(_i3.Article article) =>
      caller.callServerEndpoint<bool>(
        'artikool',
        'editArticle',
        {'article': article},
      );

  _i2.Future<bool> deleteArticle(int id) => caller.callServerEndpoint<bool>(
        'artikool',
        'deleteArticle',
        {'id': id},
      );

  _i2.Future<_i4.WeatherInfo> getWeatherInfo(int cityId) =>
      caller.callServerEndpoint<_i4.WeatherInfo>(
        'artikool',
        'getWeatherInfo',
        {'cityId': cityId},
      );

  _i2.Future<String> getString() => caller.callServerEndpoint<String>(
        'artikool',
        'getString',
        {},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i5.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i6.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    artikool = _EndpointArtikool(this);
    example = _EndpointExample(this);
  }

  late final _EndpointArtikool artikool;

  late final _EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'artikool': artikool,
        'example': example,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
