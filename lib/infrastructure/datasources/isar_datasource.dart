import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<bool> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return Future<bool>.value(false);
    }

    return isar.writeTxnSync(() {
      isar.movies.putSync(movie);
      return Future<bool>.value(true);
    });
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }
}
