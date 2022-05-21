import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../repositories/data_repository.dart';
import '../../shared/constants.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bbwBackgroundColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/netflix_logo_1.png'),
        SpinKitFadingCircle(
          color: bbwPrimaryColor,
          size: 20,
        )
      ]),
    );
  }
}
