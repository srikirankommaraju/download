import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:offline_downloads_demo/offline_downloads.dart';
import 'package:path_provider/path_provider.dart';

class OnlineList extends StatefulWidget with WidgetsBindingObserver {
  @override
  _OnlineListState createState() => _OnlineListState();
}

class _OnlineListState extends State<OnlineList> {
  final _urls = [
    'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online links'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfflineDownloads(),
          ),
        ),
        label: Text('Downloads'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _urls.length,
          itemBuilder: (BuildContext context, int i) {
            String _fileName = 'File ${i + 1}';
            return Card(
              elevation: 10,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_fileName),
                      ),
                      RawMaterialButton(
                        textStyle: TextStyle(color: Colors.blueGrey),
                        onPressed: () => requestDownload(_urls[i], _fileName),
                        child: Icon(Icons.file_download),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> requestDownload(String _url, String _name) async {
    final dir = await getApplicationDocumentsDirectory();
    var _localPath = dir.path + _name;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String _taskid = await FlutterDownloader.enqueue(
        url: _url,
        fileName: _name,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: false,
      );
      print(_taskid);
    });
  }
}
