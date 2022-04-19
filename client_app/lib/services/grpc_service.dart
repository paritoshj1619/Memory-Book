import 'package:client_app/protos/service.pbgrpc.dart';
import 'package:client_app/utils/constants.dart';
import 'package:grpc/grpc.dart';

class GrpcService {
  MemoryBookServiceClient? client;

  Future grpcConnection() async {
    return ClientChannel(
      kServerURL,
      port: kPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
  }

  Future createUser(User body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      final res = await client?.createUser(
        User()
          ..name = body.name
          ..emailAddress = body.emailAddress,
      );
      return res;
    } catch (err) {
      throw "cannot register user";
    }
  }

  Future loginUser(String body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      final res = await client?.login(
        User()..secretCode = body,
      );
      return res;
    } catch (err) {
      throw "cannot find user";
    }
  }

  Future getAllPhotos(String body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      final res = await client?.getAllPhotos(
        Photo()..secretCode = body,
      );
      return res;
    } catch (err) {
      print(err);
      throw "cannot fetch all photos";
    }
  }

  Future storePhoto(Photo body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      final res = await client?.storePhoto(
        Photo()
          ..secretCode = body.secretCode
          ..byteCode = body.byteCode
          ..dateOfCreation = DateTime.now().toIso8601String().split("T")[0]
          ..description = body.description
          ..location = body.location,
      );
      return res;
    } catch (err) {
      print(err);
      throw "cannot store photo";
    }
  }

  Future updatePhoto(Photo body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      final res = await client?.updatePhoto(
        Photo()
          ..secretCode = body.secretCode
          ..id = body.id
          ..description = body.description,
      );
      return res;
    } catch (err) {
      print(err);
      throw "cannot update photo";
    }
  }

  Future deletePhoto(int body) async {
    client = MemoryBookServiceClient(await grpcConnection());
    try {
      await client?.deletePhoto(
        Photo()..id = body,
      );
    } catch (err) {
      print(err);
      throw "cannot delete photo";
    }
  }
}
