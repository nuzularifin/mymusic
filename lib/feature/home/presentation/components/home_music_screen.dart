import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/feature/home/presentation/bloc/home_music_bloc.dart';

import 'home_music_items.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  Song? currentSong;
  String searchSong = "";
  List<Song> songList = [];
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int selectedIndex = -1;
  final TextEditingController _inputSearchMusic = TextEditingController();

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    refreshMusic('jason');
  }

  void startListener() {
    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      BlocProvider.of<HomeMusicBloc>(context).add(
          PauseTheMusicEvent(fromList: songList, selectedSong: currentSong!));
    });

    if (currentSong != null) {
      audioPlayer.setUrl(currentSong!.previewUrl);
    }
  }

  void refreshMusic(String search) {
    BlocProvider.of<HomeMusicBloc>(context).add(GetAllSongsEvent(term: search));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            onSubmitted: (value) {
              _inputSearchMusic.text = value;
              refreshMusic(_inputSearchMusic.text);
            },
            controller: _inputSearchMusic,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                    _inputSearchMusic.text = "";
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: BlocConsumer<HomeMusicBloc, HomeMusicState>(
        listener: (context, state) {
          if (state is HomeMusicLoading) {
            // adding to list data
          }
          if (state is HomeMusicLoaded) {
            songList = state.song;
          }
          if (state is SelectedSongState) {
            currentSong = state.currentSong;
          } else if (state is PlayMusicState) {
            currentSong = state.currentSong;
            audioPlayer.stop();
            audioPlayer.play(currentSong!.previewUrl);
            audioPlayer.setUrl(currentSong!.previewUrl);
            startListener();
            songList = state.currentSongList;
          } else if (state is PauseMusicState) {
            currentSong = state.currentSong;
            audioPlayer.pause();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state is HomeMusicLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state is HomeMusicError)
                const Expanded(
                  child: Center(
                      child: Text(
                    'Empty Track',
                    style: TextStyle(fontSize: 14),
                  )),
                )
              else
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: ListView.builder(
                      itemCount: songList.isNotEmpty ? songList.length : 0,
                      itemBuilder: (context, index) => HomeMusicItems(
                          songName: songList[index].trackName,
                          artisName: songList[index].artistName,
                          albumName: songList[index].collectionName,
                          cover: songList[index].artworkUrl60,
                          isSelected: songList[index].isSelected,
                          isPlay: songList[index].isPlay,
                          onTap: () {
                            BlocProvider.of<HomeMusicBloc>(context)
                                .add(SelectSongToPlayEvent(
                              selectedSong: songList[index],
                              songs: songList,
                            ));
                          })),
                )),
              // Build the player music
              currentSong != null
                  ? Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color(0x55121212), blurRadius: 4.0)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 14.0, right: 14.0, top: 6.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                currentSong!.artworkUrl30)),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(currentSong!.trackName,
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(currentSong!.artistName,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // btnPrevious(),
                                btnStart(currentSong!),
                                // btnNext(),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _position.toString().split('.')[0],
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Text(
                                    Duration(seconds: _duration.inSeconds)
                                        .toString()
                                        .split('.')[0],
                                    style: const TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Slider.adaptive(
                              value: _position.inSeconds.toDouble(),
                              max: _duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                seekToSec(value.toInt());
                              }),
                        ],
                      ))
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget btnStart(Song currentSong) {
    return IconButton(
        iconSize: 35,
        color: Colors.blue,
        onPressed: () {
          if (!currentSong.isPlay) {
            BlocProvider.of<HomeMusicBloc>(context).add(
                PlayTheMusicEvent(selectedSong: currentSong, songs: songList));
          } else if (currentSong.isPlay) {
            BlocProvider.of<HomeMusicBloc>(context).add(PauseTheMusicEvent(
                fromList: songList, selectedSong: currentSong));
          }
        },
        icon: !currentSong.isPlay ? Icon(_icons[0]) : Icon(_icons[1]));
  }

  void seekToSec(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    audioPlayer.seek(newDuration);
  }
}
