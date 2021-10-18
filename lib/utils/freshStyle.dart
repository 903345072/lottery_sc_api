import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class freshStyle{
  static Widget getHeader(_headerKey) {
    return ClassicsHeader(
      key: _headerKey,
      refreshText: '下拉刷新',
      refreshReadyText: '准备刷新',
      refreshingText: '刷新中...',
      refreshedText: '刷新完成',
      moreInfo: '更新于 %T',
      bgColor: Colors.black26,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }

  static Widget getFooter(_footerKey) {
    return ClassicsFooter(
      key: _footerKey,
      loadText: '上拉加载',
      loadReadyText: '准备加载',
      loadingText: '加载中...',
      loadedText: '加载完成',
      noMoreText: '加载完成',
      moreInfo: '更新于 %T',
      bgColor: Colors.lightBlueAccent,
      textColor: Colors.black87,
      moreInfoColor: Colors.black54,
      showMore: true,
    );
  }
}