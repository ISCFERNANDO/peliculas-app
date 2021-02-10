class Peliculas {
  List<Pelicula> items;

  Peliculas();

  Peliculas.fromJsonMap(List<dynamic> jsonList) {
    if (jsonList == null) return;
    items = jsonList.map((item) => Pelicula.fromJsonMap(item)).toList();
  }
}

class Pelicula {
  String uniqueId;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> jsonMap) {
    adult = jsonMap['adult'];
    backdropPath = jsonMap['backdrop_path'];
    genreIds = jsonMap['genre_ids'].cast<int>();
    id = jsonMap['id'];
    originalLanguage = jsonMap['original_language'];
    originalTitle = jsonMap['original_title'];
    overview = jsonMap['overview'];
    popularity = jsonMap['popularity'] / 1;
    posterPath = jsonMap['poster_path'];
    releaseDate = jsonMap['release_date'];
    title = jsonMap['title'];
    video = jsonMap['video'];
    voteAverage = jsonMap['vote_average'] / 1;
    voteCount = jsonMap['vote_count'];
  }

  getPosterImage() {
    if (posterPath == null) {
      return 'https://i.stack.imgur.com/y9DpT.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackdropImage() {
    if (backdropPath == null) {
      return 'https://i.stack.imgur.com/y9DpT.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
