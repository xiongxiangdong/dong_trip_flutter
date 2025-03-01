import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/travel_tab_model.dart';

class TravelItemWidget extends StatelessWidget {
  const TravelItemWidget({super.key, required this.item, this.index});

  final TravelItem item;
  final int? index;

  get _nick {
    return Row(
      children: [
        PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.article?.author?.coverImage?.dynamicUrl ?? "",
            width: 24,
            height: 24,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: 80,
          child: Text(
            item.article?.author?.nickName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        )
      ],
    );
  }

  get _like => Row(
        children: [
          Icon(
            Icons.thumb_up,
            size: 14,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              item.article?.likeCount.toString() ?? "",
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          )
        ],
      );

  Widget _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(minHeight: size.width / 2 - 10),
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.article?.images?[0].dynamicUrl ?? "",
              fit: BoxFit.cover),
        ),
        Positioned(
            left: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 100,
                    child: Text(
                      _getCity(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  _getCity() {
    return item.article?.poiName ?? "未知";
  }

  _title(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Text(
        item?.article?.articleTitle ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }

  _info(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _nick,
        _like,
      ],
    );
  }

  _getContent(BuildContext context) {
    return Card(
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(6),
        child: Column(
          children: [
            _itemImage(context),
            _title(context),
            _info(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: _getContent(context),
    );
  }
}
