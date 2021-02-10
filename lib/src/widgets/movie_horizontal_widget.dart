import 'package:flutter/material.dart';
import 'package:pelicupas_app/src/models/pelicula_model.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function loadNewData;
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  MovieHorizontalWidget(
      {@required this.peliculas, @required this.loadNewData, Key key})
      : assert(peliculas != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        loadNewData();
      }
    });

    return Container(
      height: screenSize.height * 0.3 - 16.0,
      width: double.infinity,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, index) =>
            _buildPageCard(context, screenSize, peliculas[index]),
      ),
    );
  }

  Widget _buildPageCard(
      BuildContext context, Size screenSize, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-movie_horizontal';
    final cardMovie = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                //height: screenSize.height * 0.25,
                height: 144.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, 'detalle_pelicula', arguments: pelicula),
      child: cardMovie,
    );
  }
}
