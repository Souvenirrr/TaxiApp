import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/place_bloc.dart';
import 'package:taxi_app/src/model/place_item_res.dart';

class RidePickerPage extends StatefulWidget {
  final String selectAddress;
  final Function(PlaceItemRes, bool) onSeclected;
  final bool _isFromAddress;
  RidePickerPage(this.selectAddress, this.onSeclected, this._isFromAddress);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _addressController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addressController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 60,
                        child: Center(
                          child: Image.asset("ic_location_black.png"),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: Center(
                          child: FlatButton(onPressed: () {
                            _addressController = "";
                          }, child: Image.asset("ic_remove_x.png")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addressController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (str) {
                            placeBloc.searchPlace(str);
                          },
                          style: TextStyle(fontSize: 16, color: Color(0xff323643)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      print(snapshot.data.toString());
                    if(snapshot.data == "start"){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print(snapshot.data.toString());
                    List<PlaceItemRes> places = snapshot.data;
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(places.elementAt(index).name),
                            subtitle: Text(places.elementAt(index).address),
                            onTap: () {
                              print("on tap");
                              Navigator.of(context).pop();
                              widget.onSeclected(places.elementAt(index),
                                widget._isFromAddress);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Color(0xfff5f5f5),
                        ),
                        itemCount: places.length,
                    );
                    } else{
                      return Container();
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
