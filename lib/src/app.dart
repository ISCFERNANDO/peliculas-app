import 'package:flutter/material.dart';
import 'package:pelicupas_app/src/screens/home_screen.dart';
import 'package:pelicupas_app/src/screens/movie_detail_screen.dart';
import 'package:pelicupas_app/src/utils/colors.dart';

class PeliculasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //brightness: Color(0xff00365e),
        //primarySwatch: Color(0xff002171),
        primaryColor: Color(primaryColor),
        accentColor: Color(lightColor),
        primaryColorLight: Color(lightColor),

        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(
              fontSize: 24.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          subtitle1: TextStyle(fontSize: 14.0, color: Colors.white),
          caption: TextStyle(fontSize: 12.0, color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Color(primaryColor),
        ),
      ),
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        'detalle_pelicula': (context) => MovieDetailScreen()
      },
    );
  }
}
