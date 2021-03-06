import 'package:flutter/material.dart';

class HomeMusicItems extends StatefulWidget {
  String? songName;
  String? artisName;
  String? albumName;
  String? cover;
  bool? isSelected;
  bool? isPlay;
  dynamic onTap;

  HomeMusicItems(
      {Key? key,
      this.songName,
      this.artisName,
      this.albumName,
      this.cover,
      this.isSelected = false,
      this.isPlay = false,
      this.onTap})
      : super(key: key);

  @override
  State<HomeMusicItems> createState() => _HomeMusicItemsState();
}

class _HomeMusicItemsState extends State<HomeMusicItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/music_placeholder.png',
                    image: widget.cover!),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.songName!,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5.0),
                  Text(widget.artisName!,
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 5.0),
                  Text(widget.albumName!,
                      style: const TextStyle(fontSize: 12.0)),
                ],
              ),
            ),
            const SizedBox(width: 4.0),
            widget.isPlay!
                ? const Icon(
                    Icons.play_circle,
                    color: Colors.blue,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
