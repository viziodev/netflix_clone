import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/data_repository.dart';
import '../../shared/constants.dart';
import '../widgets/movie_card_widget.dart';
import '../widgets/movie_categorie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getMovies();
  }

  /*  void getMovies() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getPopularMovies();
  } */

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: bbwBackgroundColor,
      appBar: AppBar(
        backgroundColor: bbwBackgroundColor,
        leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: ListView(children: [
        SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first)),
        MovieCategorie(
          movieList: dataProvider.popularMovieList,
          label: "Tendances actuelles",
          imageHeight: 160,
          imageWidth: 110,
          callback: dataProvider.getPopularMovies,
        ),
        //"Actuellement au Cinema", 320,220
        MovieCategorie(
          movieList: dataProvider.nowPlaying,
          label: "Actuellement au Cinema",
          imageHeight: 360,
          imageWidth: 220,
          callback: dataProvider.getnowPlaying,
        ),
        //"Bientot Disponible",160,110
        MovieCategorie(
          movieList: dataProvider.upcomingMovies,
          label: "Bientot Disponible",
          imageHeight: 160,
          imageWidth: 110,
          callback: dataProvider.getUpcomingMovies,
        ),
        MovieCategorie(
          movieList: dataProvider.animationMovies,
          label: "Animations",
          imageHeight: 320,
          imageWidth: 220,
          callback: dataProvider.getAnimationMovies,
        ),
      ]),
    );
  }
}
