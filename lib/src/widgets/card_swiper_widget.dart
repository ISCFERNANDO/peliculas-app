import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pelicupas_app/src/models/pelicula_model.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  const CardSwiperWidget({
    @required this.peliculas,
    Key key,
  })  : assert(peliculas != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Swiper(
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-card_swiper';

          final cardMovie = Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(peliculas[index].getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detalle_pelicula',
                arguments: peliculas[index]),
            child: cardMovie,
          );
        },
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
