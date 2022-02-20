import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/screens/loading.dart';
import 'package:movie_app/widgets/seacrh/search_delegate.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    
    final moviesProvider = Provider.of<MovieProvier>(context,listen: true);

    if ( moviesProvider.NowPlayingMovies.length == 0 ) { return LoadingScreen(); }

    return Scaffold(

      appBar: AppBar(
        title: Text("Peliculas en cine"),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context, 
              delegate: MovieSearchDelegate()
            ),
            icon: Icon(Icons.search_outlined),
            padding: EdgeInsets.all(16),
            )],
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            CardSwiper(movies: moviesProvider.NowPlayingMovies),
            MovieSlider(
              movies: moviesProvider.PopularMovies,
              OnNextPage: () => moviesProvider.getPopularMovies(),
              ),
          ],
          
        ),
      ),
       
      
    );
  }
}