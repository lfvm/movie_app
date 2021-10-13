import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';



class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; //Tamaño de la pantalla
  
    return Container(
      width: double.infinity, //Match parent
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.width * 0.9,
        itemBuilder: (_ ,int index){

          final movie = movies[index];



          return GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, "details",arguments: movie),
            child: Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  image: NetworkImage(movie.fullPosterImg),
                  placeholder: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }

      )

      
    );
  }
}