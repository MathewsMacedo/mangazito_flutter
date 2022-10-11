import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:manga_app/widgets/loading.dart';

class MangaItemWidget extends StatefulWidget {
  const MangaItemWidget({required this.image, Key? key}) : super(key: key);
  final String image;

  @override
  State<MangaItemWidget> createState() => _MangaItemWidgetState();
}

class _MangaItemWidgetState extends State<MangaItemWidget> {
  final _transformationController = TransformationController();
  late TapDownDetails _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        maxScale: 15,
        clipBehavior: Clip.none,
        transformationController: _transformationController,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: CachedNetworkImage(
            imageUrl: widget.image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Loading(
              white: true,
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }
}
