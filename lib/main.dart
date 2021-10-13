import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/details.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(AppState());

//Clase para definir los proveedores de la api
class AppState extends StatelessWidget {

  @override
  
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MovieProvier(),lazy: false,)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "home",
      home: MainScreen(),
      routes: {
        "home" : (_) => MainScreen(),
        "details" : (_) => DetailPage(),

      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.indigo)
      ),
    );
  }
}