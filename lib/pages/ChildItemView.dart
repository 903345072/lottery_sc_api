import 'package:flutter/cupertino.dart';

class ChildItemView extends StatefulWidget {
  String _title;

  ChildItemView(this._title);
  @override
  _ChildItemViewState createState() => _ChildItemViewState();
}
class _ChildItemViewState extends State<ChildItemView>with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    print("chilview11111");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(widget._title)),
    );
  }
}
