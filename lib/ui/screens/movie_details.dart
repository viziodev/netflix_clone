import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflex/ui/widgets/image_card.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/movie.dart';
import '../../repositories/data_repository.dart';
import '../../shared/constants.dart';
import '../widgets/action_button.dart';
import '../widgets/casting_card.dart';
import '../widgets/movie_info.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;
  YoutubePlayerController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bbwBackgroundColor,
      appBar: AppBar(
        backgroundColor: bbwBackgroundColor,
        // leading: Image.asset('assets/images/netflix_logo_2.png'),
      ),
      body: newMovie == null
          ? Center(
              child: SpinKitFadingCircle(
                color: bbwPrimaryColor,
                size: 20,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  MovieInfo(
                    newMovie: newMovie!,
                    controller: _controller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ActionButton(
                    label: "Lecture",
                    icon: Icons.play_arrow,
                    bgColor: Colors.white,
                    color: bbwBackgroundColor,
                    onPause: () {
                      _controller!.pause();
                    },
                    onPlay: () {
                      _controller!.play();
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ActionButton(
                      label: "Telecharcher la video",
                      icon: Icons.download,
                      bgColor: Colors.grey.withOpacity(0.3),
                      color: Colors.white),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    newMovie!.description,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Casting",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                      itemCount: newMovie!.casting!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return newMovie!.casting![index] == null
                            ? const Center()
                            : CastingCard(person: newMovie!.casting![index]);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Images",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: newMovie!.images!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return newMovie!.images![index] == null
                            ? const Center()
                            : ImageCard(image: newMovie!.images![index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    //Recupere les detail d'un movie
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
      print("${newMovie!.id}");
      /* _controller = YoutubePlayerController(
        initialVideoId: "${newMovie!.id}",
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          hideThumbnail: true,
        ),
      );*/
    });
  }
}
