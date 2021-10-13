import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';


class CastingCard extends StatelessWidget {

  final int movieID;

  const CastingCard(this.movieID);



  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MovieProvier>(context,listen: false);

    return FutureBuilder(
      future: moviesProvider.getCastMembers(movieID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        

        if (snapshot.data == null){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 210,
            width: double.infinity,
            child: CupertinoActivityIndicator(),
          );
        }
      

        final castResponse = snapshot.data;

        return Container(
          margin: EdgeInsetsDirectional.only(bottom: 16),

          width: double.infinity,
          height: 210,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_,int index) => _castCard(castResponse[index])
          ),
        );
      },
    );
  }
}


class _castCard extends StatelessWidget {

  final Cast character;

  const _castCard( this.character);

  

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 110,
      height: 100,
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("assets/loading.gif"),
              image: NetworkImage(character.fullprofilepath),
              height: 145,
            ),
          ),
          SizedBox(height: 10,),
          Text(character.name,style: textTheme.subtitle2, overflow: TextOverflow.ellipsis,)
        ],
      )
    );
  }
}