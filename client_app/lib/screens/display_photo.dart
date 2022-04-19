import 'dart:typed_data';
import 'package:client_app/protos/service.pb.dart';
import 'package:client_app/services/grpc_service.dart';
import 'package:flutter/material.dart';

class DisplayPhoto extends StatefulWidget {
  const DisplayPhoto({Key? key}) : super(key: key);

  @override
  _DisplayPhotoState createState() => _DisplayPhotoState();
}

class _DisplayPhotoState extends State<DisplayPhoto> {
  late String updateDescription;
  var grpcService = GrpcService();

  @override
  Widget build(BuildContext context) {
    var body = ModalRoute.of(context)?.settings.arguments as Photo;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 60.0,
              color: Colors.grey[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    enableFeedback: true,
                  ),
                  const Text(
                    "Memory Book",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      letterSpacing: 4.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await grpcService.deletePhoto(body.id);
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    enableFeedback: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                left: 30.0,
                right: 30.0,
              ),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 200.0,
                    child: Image.memory(
                      Uint8List.fromList(body.byteCode),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color(0x9FFFC000),
                          width: 3.0,
                        ),
                      ),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Description:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  body.description,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Date:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  body.dateOfCreation,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text(
                                  "Location:",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  body.location,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text("Add description"),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      onChanged: (value) => updateDescription = value,
                      validator: (String? val) {
                        return val!.isEmpty ? "Description is required" : null;
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    FlatButton(
                      onPressed: () async {
                        body.description = updateDescription;
                        var result = await grpcService.updatePhoto(body);
                        setState(() {
                          body = result;
                        },);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        child: const Icon(Icons.update),
        backgroundColor: Colors.green,
      ),
      bottomSheet: const Padding(
        padding: EdgeInsets.only(
          bottom: 40.0,
        ),
      ),
    );
  }
}
