import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/home/presentation/bloc/home_music_bloc.dart';
import 'feature/home/presentation/components/home_music_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeMusicBloc>(create: (_) => di.sl<HomeMusicBloc>())
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: MusicApp(),
      ),
    );
  }
}
