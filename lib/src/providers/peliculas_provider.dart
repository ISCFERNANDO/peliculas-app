import 'dart:async';
import 'dart:convert';

import 'package:pelicupas_app/src/models/actores_model.dart';
import 'package:pelicupas_app/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apiKey = '02e423483afa5db602c3342ddcfb3f22';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  List<Pelicula> _populares = List();
  bool _loading = false;

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final peliculas = Peliculas.fromJsonMap(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return _procesarRespuesta(url);
  }

  Future<void> getPopulares() async {
    if (_loading) {
      return;
    }
    _loading = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });
    final peliculas = await _procesarRespuesta(url);
    _populares.addAll(peliculas);
    popularesSink(_populares);
    _loading = false;
  }

  Future<List<Actor>> getActores(int movieId) async {
    final url = Uri.https(_url, '/3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final data = await _procesarRespuesta(url);
    return data;
  }
}
