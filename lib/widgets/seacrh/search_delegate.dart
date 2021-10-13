

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {


  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar pelicula";

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(onPressed: () => query = "", icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(icon: Icon(Icons.arrow_back),
    onPressed: () {
      close(context,null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("Build results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final provider = Provider.of<MovieProvier>(context,listen: false);
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return Container(
        child: Center(
          child:Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 130,)
        ,),
      );
    }

    return FutureBuilder(

      future:provider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){

        if(snapshot.data == null){
          return Container(
            child: Center(
              child:Icon(Icons.movie_creation_outlined,color: Colors.black38,size: 130,)
            ,),
          );
        } 

        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_,int index) => buildSguestion(movies[index])
      );
    }
  );
  
    
  }


}


class buildSguestion extends StatelessWidget {

  final Movie movie;

  const buildSguestion(this.movie);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: FadeInImage(
        placeholder: AssetImage("assets/loading.gif"),
        image: NetworkImage(movie.fullPosterImg),
      ),

      title: Text(movie.title),
      subtitle: Text("${movie.voteAverage}"),

      onTap: () {
        Navigator.pushNamed(context, "details",arguments: movie);
      },
      
    );
  }
}