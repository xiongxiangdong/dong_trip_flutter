import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/widget/loading_container_widget.dart';
import 'package:trip_flutter/widget/travel_item_widget.dart';

import '../model/travel_tab_model.dart';

class TravelTabPage extends StatefulWidget {
  const TravelTabPage({super.key, required this.code});

  final String code;

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  TravelTabModel? travelTabModel;
  List<TravelItem> list = [];
  bool _loading = true;

  @override
  void initState() {
    _loadData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });

    super.initState();
  }

  Future<void> _loadData({loadMore = false}) async {
    if (loadMore) {
      page = page + 1;
    } else {
      page = 1;
    }
    try {
      TravelTabModel? mode = await TravelDao.getDetail(widget.code, page, 10);
      List<TravelItem> items = mode?.list ?? [];
      travelTabModel = mode;
      if (items.isEmpty) {
        page--;
      }
      List<TravelItem> result = [];
      if (items != null) {
        for (var item in items) {
          if (item.article != null) {
            result.add(item);
          }
        }
      }
      setState(() {
        _loading = false;
        if (loadMore) {
          list.addAll(result);
        } else {
          list = result;
        }
      });
    } catch (e) {
      _loading = false;
      if (loadMore) {
        page--;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainerWidget(
          isLoading: _loading,
          child: RefreshIndicator(
              onRefresh: _loadData,
              child: MediaQuery.removePadding(
                  context: context, removeTop: true, child: _gridView))),
    );
  }

  get _getData {
    return Container(
      child: Text(jsonEncode(list)),
    );
  }

  final ScrollController scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
      controller: scrollController,
      crossAxisCount: 2,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return TravelItemWidget(index: index, item: list[index]);
      });

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
