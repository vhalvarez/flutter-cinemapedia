import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credist_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': 'es-MX'},
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors =
        castResponse.cast
            .map((cast) => ActorMapper.castToEntity(cast))
            .toList();

    return actors;
  }
}
