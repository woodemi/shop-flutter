import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:shopflutter/GoodModel.dart';
import 'package:shopflutter/ServerManager.dart';
import 'package:shopflutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woodemi_service/WoodemiService.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopPageState();
  }
}

class _ShopPageState extends State<ShopPage> with WoodemiService {
  var _activitys = List<ShopModel>();
  var _goods = List<ShopModel>();

  @override
  void initState() {
    super.initState();
    print('ShopPage initState');
    _requestShop();
  }

  @override
  void dispose() {
    super.dispose();
    print('ShopPage dispose');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        "商城",
        implyLeading: true,
        centerTitle: false,
        titleStyle: TextStyle(fontSize: 24, color: Colors.black87),
      ),
      body: _buildListView(),
    );
  }

  Widget activity() {
    return GestureDetector(
      child: Container(
        child: AspectRatio(
          aspectRatio: 2.0,
          child:
              _activitys.length > 0 ? Image.network(_activitys[0].gif) : null,
        ),
      ),
      onTap: () async {
        if (_activitys.length == 0) return;
        var model = _activitys[0];
        if (model.url != null && model.url.length > 0) {
          if (await canLaunch(model.url)) {
            await launch(model.url);
            return;
          }
        }
      },
    );
  }

  int getHeaderCount() => _activitys.length > 0 ? 1 : 0;

  ListView _buildListView() {
    return ListView.builder(
      itemCount: 1 + getHeaderCount(),
      padding: EdgeInsets.symmetric(vertical: 21.0, horizontal: 18.0),
      itemBuilder: (ctx, index) {
        if (getHeaderCount() > 0 && index == 0) return activity();
        return Column(
          children: <Widget>[
            Table(
              children: partition(_goods, 2).map((items) {
                var itemWidgets =
                    items.cast<ShopModel>().map(_buildItem).toList();
                var dummyWidgets =
                    List.generate(items.length % 2, (index) => Container());
                return TableRow(children: itemWidgets..addAll(dummyWidgets));
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem(ShopModel model) {
    return Container(
      margin: EdgeInsets.all(13),
      child: AspectRatio(
        aspectRatio: 136.0 / 200.0,
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Align(
                child: Image.network(model.thumb),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(model.name),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('\￥' + model.prize),
              ),
            ],
          ),
          onTap: () async {
            var url = model.url;
            if (url != null && url.length > 0) {
              if (await canLaunch(url)) {
                await launch(url);
                return;
              }
            }
          },
        ),
      ),
    );
  }

  _requestShop() async {
    var url = '${sServerManager.userServiceUrl}/config/app/shop';
    Map response = await getJson(url, {});
    var value = response['value'];
    var map = json.decode(value) as Map;
    var activitys = ShopModel.fromMapList(map['activity']);
    var goods = ShopModel.fromMapList(map['goods']);

    setState(() {
      _activitys = activitys;
      _goods = goods;
    });
  }
}
