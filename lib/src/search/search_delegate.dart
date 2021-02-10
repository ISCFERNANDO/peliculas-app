import 'package:flutter/material.dart';
import 'package:pelicupas_app/src/models/pelicula_model.dart';
import 'package:pelicupas_app/src/providers/peliculas_provider.dart';

class DataSearchDelegate extends SearchDelegate {
  final _peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones del appbar, ej (icono para limpiar texto, cancelar, etc)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //  icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crear los resultados que vamos a mostrar
    /* return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    ); */
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: _peliculasProvider.buscarPelicula(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pelicula> movies = snapshot.data;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  movies[index].title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  movies[index].originalTitle,
                  style: TextStyle(color: Colors.black54),
                ),
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movies[index].getPosterImage()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  close(context, null);
                  movies[index].uniqueId = '';
                  Navigator.pushNamed(
                    context,
                    'detalle_pelicula',
                    arguments: movies[index],
                  );
                },
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /* @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias que aparecen cuan se escribe en el input
    final suggestionList = (query.isEmpty)
        ? peliculasRecientes
        : peliculasRecientes
            .where((m) => m.toLowerCase().indexOf(query.toLowerCase()) != -1)
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(
            suggestionList[index],
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            seleccion = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  } */

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
}
