import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/feature/home/presentation/bloc/home_music_bloc.dart';

import 'custom_list_tile.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  Song? currentSong;
  String searchSong = "";
  Duration _duration = Duration();
  Duration _position = Duration();
  List<Song> songList = [];
  int selectedIndex = -1;
  final TextEditingController _inputSearchMusic = TextEditingController();

  bool isPlaying = false;
  bool isPause = false;

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  @override
  void initState() {
    super.initState();
    refreshMusic('jason');

    audioPlayer.onDurationChanged.listen((d) {
      print('Max duration: $d');
      setState(() {
        _duration = d;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      print('Current position: $p');
      setState(() {
        _position = p;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        isPlaying = false;
      });
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
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
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
      body: Column(
        children: [
          // This item has 2 compose view like list playlist and player
          BlocConsumer<HomeMusicBloc, HomeMusicState>(
            listener: (context, state) {
              if (state is HomeMusicLoading) {
                // adding to list data
              }
              if (state is HomeMusicLoaded) {
                setState(() {
                  songList = [];
                  songList.addAll(state.song);
                });
              }
            },
            builder: (context, state) {
              if (state is HomeMusicLoaded) {
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: ListView.builder(
                      itemCount: songList.isNotEmpty ? songList.length : 0,
                      itemBuilder: (context, index) => CustomListTile(
                          songName: songList[index].trackName,
                          artisName: songList[index].artistName,
                          albumName: songList[index].collectionName,
                          cover: songList[index].artworkUrl60,
                          isSelected: songList[index].isSelected,
                          onTap: () {
                            setState(() {
                              if (selectedIndex != -1) {
                                songList[selectedIndex].isSelected = false;
                              }
                              songList[index].isSelected = true;
                              selectedIndex = index;
                              currentSong = songList[index];
                              _duration = Duration(
                                  milliseconds: currentSong!.trackTimeMillis);
                            });
                          })),
                ));
              } else if (state is HomeMusicLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const Expanded(
                  child: Center(
                      child: Text(
                    'Empty Track',
                    style: TextStyle(fontSize: 14),
                  )),
                );
              }
            },
          ),
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
                                  Container(
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
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(currentSong!.artistName,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // btnPrevious(),
                            btnStart(currentSong!.previewUrl),
                            // btnNext(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _position.toString().split('.')[0],
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                                '${Duration(milliseconds: currentSong!.trackTimeMillis).toString().split('.')[0]}',
                                style: TextStyle(fontSize: 10)),
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
      ),
    );
  }

  Widget btnStart(String url) {
    return IconButton(
        iconSize: 35,
        color: Colors.blue,
        onPressed: () {
          if (!isPlaying) {
            audioPlayer.play(url);
            audioPlayer.setUrl(url);
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying) {
            audioPlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        },
        icon: !isPlaying ? Icon(_icons[0]) : Icon(_icons[1]));
  }

  Widget btnNext() {
    return IconButton(
        color: Colors.blue,
        iconSize: 30,
        onPressed: () {},
        icon: const Icon(Icons.skip_next));
  }

  Widget btnPrevious() {
    return IconButton(
        color: Colors.blue,
        iconSize: 30,
        onPressed: () {},
        icon: const Icon(Icons.skip_previous));
  }

  void seekToSec(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    audioPlayer.seek(newDuration);
  }
}
