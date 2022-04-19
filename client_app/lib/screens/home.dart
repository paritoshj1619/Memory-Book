import 'dart:io';
import 'dart:typed_data';
import 'package:client_app/protos/service.pb.dart';
import 'package:client_app/services/grpc_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var photoId = 0;
  Photos? photos = Photos();
  var secretCode = "";
  final grpcService = GrpcService();
  final _descriptionForm = GlobalKey<FormState>();
  late String description;
  bool isLoading = true;

  Future getAddress(Position position) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = newPlace[0];
    return "${address.name}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea} ${address.postalCode}, ${address.country}";
  }

  Future getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getSecretCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("secret_code")!;
  }

  Future _readImgByte(File imageTemp) async {
    Uint8List? bytes;
    await imageTemp.readAsBytes().then((val) {
      bytes = Uint8List.fromList(val);
    }).catchError((onError) {
      print("Exception while reading image: ${onError.toString()}");
    });
    return bytes;
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      var imageTemp = File(image.path);
      var body = Photo();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Add description"),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _descriptionForm,
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
                    onChanged: (value) => description = value,
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
                      LoadingFlipping.circle(
                        borderColor: Colors.cyan,
                        borderSize: 3.0,
                        size: 60.0,
                      );
                      body.secretCode = secretCode;
                      body.description = description;
                      body.location =
                          await getAddress(await getGeoLocationPosition());
                      try {
                        Uint8List photoByte = await _readImgByte(imageTemp);
                        body.byteCode = photoByte;
                      } catch (err) {
                        print(err.toString());
                      }
                      var result = await grpcService.storePhoto(body);
                      setState(() {
                        photos!.photos.add(result);
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } catch (err) {
      print('Failed to pick image: $err');
    }
  }

  @override
  void initState() {
    super.initState();
    getSecretCode().then(
      (val) async {
        secretCode = val;
        var result = await grpcService.getAllPhotos(secretCode);
        setState(() {
          photos = result;
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.grey[900],
            body: photos!.photos.isNotEmpty
                ? Column(
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        color: Colors.grey[800],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Memory Book",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                letterSpacing: 4.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: photos!.photos.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/display-photo',
                                        arguments: photos!.photos[index])
                                    .then((val) {
                                  if (val != null) {
                                    setState(() {
                                      photos!.photos.removeAt(index);
                                    });
                                  }
                                });
                              },
                              child: Card(
                                child: Image.memory(
                                  Uint8List.fromList(
                                      photos!.photos[index].byteCode),
                                  height: 160.0,
                                  width: 160.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      "No photos found",
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text("Pick Image"),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          } else {
                            await Permission.camera.request();
                          }
                        },
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.add_a_photo_sharp),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              "Camera",
                            ),
                          ],
                        ),
                      ),
                      SimpleDialogOption(
                        onPressed: () async {
                          if (await Permission.storage.request().isGranted) {
                            pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          } else {
                            await Permission.storage.request();
                          }
                        },
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.add_photo_alternate_sharp),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              "Gallery",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              child: const Icon(Icons.add),
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
