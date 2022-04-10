import 'package:flutter/material.dart';

class ItemEspera extends StatefulWidget {
  final Map<String, dynamic> nonPublicData;
  ItemEspera({Key? key, required this.nonPublicData}) : super(key: key);

  @override
  State<ItemEspera> createState() => _ItemEsperaState();
}

class _ItemEsperaState extends State<ItemEspera> {
  bool _switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    _switchValue = widget.nonPublicData["public"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network("${widget.nonPublicData["picture"]}",
            fit: BoxFit.cover,),
          ),
          SwitchListTile(
            title: Text("${widget.nonPublicData["title"]}"),
            subtitle: Text("${widget.nonPublicData["publishedAt"].toDate()}"),
            value: _switchValue, 
            onChanged: (newVal){
              setState(() {
                _switchValue = newVal;
              });
          }),
        ],
      )
    );
  }
}