import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailPage extends StatefulWidget {

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {

    //Recibir datos de pantala anterior
    final Movie  movie = ModalRoute.of(context)!.settings.arguments as Movie ;
    final textTheme = Theme.of(context).textTheme;

   return Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        _CustomAppBar(),
        SliverList(
          delegate:  SliverChildListDelegate([
            _Poster(),
            Overview(),
            CastingCard(movie.id)
          ])
        ),
      ],
    ),
    );
  }
}



class _CustomAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final Movie  movie = ModalRoute.of(context)!.settings.arguments as Movie ;

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title:Text("Detalles"),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage(movie.fullImg),
          fit: BoxFit.cover,
        ),
      ),
      pinned: true,
      leading: IconButton(icon: Icon(Icons.arrow_back),
      onPressed:() => Navigator.pop(context),
  
    ),
  );
  }
}

class _Poster extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Movie  movie = ModalRoute.of(context)!.settings.arguments as Movie ;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsetsDirectional.only(top:16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Hero(
            tag:movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage("assets/loading.gif"),
                width: 100,
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),
              child:Text(movie.title,style: Theme.of(context).textTheme.headline5, 
              overflow: TextOverflow.ellipsis,),),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),
              child:Text(movie.originalTitle,style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,),),
            Row(
              children: [
                Icon(Icons.star_outline,size: 20, color: Colors.yellow,),
                SizedBox(width: 16,),
                Text("${movie.voteAverage}",style: Theme.of(context).textTheme.caption,)
              ],
            )
          ],)
        ],
      ),
    );
  }
}


class Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final Movie  movie = ModalRoute.of(context)!.settings.arguments as Movie ;

    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsetsDirectional.all(16),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: textTheme.subtitle1 ,
      ),
    );
  }
}