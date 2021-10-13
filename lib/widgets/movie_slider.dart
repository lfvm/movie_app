import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class MovieSlider extends StatefulWidget {


  final List<Movie> movies;
  final Function OnNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.OnNextPage
    }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() { 

      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent -250 ){
        widget.OnNextPage();
      }

    });
  }

  @override
  void dispose() {


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 295 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16 ),
            child: Text("Populares",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, int index)=> _moviePoster(movie: widget.movies[index],),
              itemCount: 20,
              
            ),
          )
        ],
      )
    );
  }
}




class _moviePoster extends StatelessWidget {

  final Movie movie;

  const _moviePoster({
    Key? key,
    required this.movie
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap:()=> Navigator.pushNamed(context, "details" , arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/loading.gif"),  
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(movie.originalTitle,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 2,)
        ],
      ),
    );
  }
}