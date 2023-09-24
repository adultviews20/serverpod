/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/artikool_endpoint.dart' as _i2;
import '../endpoints/example_endpoint.dart' as _i3;
import 'package:wow_server/src/generated/article.dart' as _i4;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'artikool': _i2.ArtikoolEndpoint()
        ..initialize(
          server,
          'artikool',
          null,
        ),
      'example': _i3.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
    };
    connectors['artikool'] = _i1.EndpointConnector(
      name: 'artikool',
      endpoint: endpoints['artikool']!,
      methodConnectors: {
        'getArticles': _i1.MethodConnector(
          name: 'getArticles',
          params: {
            'keywoardTitle': _i1.ParameterDescription(
              name: 'keywoardTitle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'keywoardContent': _i1.ParameterDescription(
              name: 'keywoardContent',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint).getArticles(
            session,
            keywoardTitle: params['keywoardTitle'],
            keywoardContent: params['keywoardContent'],
          ),
        ),
        'addArticle': _i1.MethodConnector(
          name: 'addArticle',
          params: {
            'article': _i1.ParameterDescription(
              name: 'article',
              type: _i1.getType<_i4.Article>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint).addArticle(
            session,
            params['article'],
          ),
        ),
        'getArticlesTotalAmont': _i1.MethodConnector(
          name: 'getArticlesTotalAmont',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint)
                  .getArticlesTotalAmont(session),
        ),
        'editArticle': _i1.MethodConnector(
          name: 'editArticle',
          params: {
            'article': _i1.ParameterDescription(
              name: 'article',
              type: _i1.getType<_i4.Article>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint).editArticle(
            session,
            params['article'],
          ),
        ),
        'deleteArticle': _i1.MethodConnector(
          name: 'deleteArticle',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint).deleteArticle(
            session,
            params['id'],
          ),
        ),
        'getWeatherInfo': _i1.MethodConnector(
          name: 'getWeatherInfo',
          params: {
            'cityId': _i1.ParameterDescription(
              name: 'cityId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint).getWeatherInfo(
            session,
            params['cityId'],
          ),
        ),
        'getString': _i1.MethodConnector(
          name: 'getString',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['artikool'] as _i2.ArtikoolEndpoint)
                  .getString(session),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i3.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
