import 'package:flutter/material.dart';
import 'package:pelicupas_app/src/providers/peliculas_provider.dart';
import 'package:pelicupas_app/src/search/search_delegate.dart';
import 'package:pelicupas_app/src/utils/colors.dart';

import 'package:pelicupas_app/src/widgets/card_swiper_widget.dart';
import 'package:pelicupas_app/src/widgets/movie_horizontal_widget.dart';

class HomeScreen extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearchDelegate(),
                //query: 'texto inciail de input',
              );
            },
          )
        ],
      ),
      body: Container(
        color: Color(primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            SizedBox(height: 16.0),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    peliculasProvider.getPopulares();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontalWidget(
                  peliculas: snapshot.data,
                  loadNewData: () => peliculasProvider.getPopulares(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
