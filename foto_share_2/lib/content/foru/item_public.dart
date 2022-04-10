import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ItemPublic extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  ItemPublic({Key? key, required this.publicFData}) : super(key: key);
  @override
  State<ItemPublic> createState() => _ItemPublicState();
}
class _ItemPublicState extends State<ItemPublic> {

  Future<File> shareTheFoto(String url) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, 'shareFoto.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.publicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text("${widget.publicFData["username"].toString()[0]}"),
              ),
              title: Text("${widget.publicFData["title"]}"),
              subtitle: Text("${widget.publicFData["publishedAt"].toDate()}"),
              trailing: Wrap(
                children: [
                  IconButton(
                    icon: Icon(Icons.star_outlined, color: Colors.green),
                    tooltip: "Likes: ${widget.publicFData["stars"]}",
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: "Compartir",
                    icon: Icon(Icons.share),
                    onPressed: () async{
                      File share_image = await shareTheFoto(widget.publicFData["picture"]);
                      List<String> imagesPaths = [];
                      imagesPaths.add(share_image.path);

                      DateTime date = widget.publicFData["publishedAt"].toDate();
                      String share_date = date.toString();

                      Share.shareFiles(imagesPaths,
                        text: widget.publicFData["title"],
                        subject: share_date,);


                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}