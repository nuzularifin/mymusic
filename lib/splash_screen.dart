import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymusic/feature/home/presentation/components/home_music_screen.dart';
import 'injection_container.dart' as di;
import 'feature/home/presentation/bloc/home_music_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(providers: [
                      BlocProvider<HomeMusicBloc>(
                          create: (_) => di.sl<HomeMusicBloc>())
                    ], child: const MusicApp()))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Center(
        child: Container(
            height: 120,
            width: 120,
            child: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/music_placeholder.png'),
              radius: 220,
            )),
      ),
    );
  }
}
