///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'service.pb.dart' as $0;
export 'service.pb.dart';

class MemoryBookServiceClient extends $grpc.Client {
  static final _$createUser = $grpc.ClientMethod<$0.User, $0.User>(
      '/proto.MemoryBookService/CreateUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$login = $grpc.ClientMethod<$0.User, $0.User>(
      '/proto.MemoryBookService/Login',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$storePhoto = $grpc.ClientMethod<$0.Photo, $0.Photo>(
      '/proto.MemoryBookService/StorePhoto',
      ($0.Photo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Photo.fromBuffer(value));
  static final _$updatePhoto = $grpc.ClientMethod<$0.Photo, $0.Photo>(
      '/proto.MemoryBookService/UpdatePhoto',
      ($0.Photo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Photo.fromBuffer(value));
  static final _$deletePhoto = $grpc.ClientMethod<$0.Photo, $0.Void>(
      '/proto.MemoryBookService/DeletePhoto',
      ($0.Photo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Void.fromBuffer(value));
  static final _$getAllPhotos = $grpc.ClientMethod<$0.Photo, $0.Photos>(
      '/proto.MemoryBookService/GetAllPhotos',
      ($0.Photo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Photos.fromBuffer(value));

  MemoryBookServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> createUser($0.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.User> login($0.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.Photo> storePhoto($0.Photo request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$storePhoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.Photo> updatePhoto($0.Photo request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePhoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.Void> deletePhoto($0.Photo request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePhoto, request, options: options);
  }

  $grpc.ResponseFuture<$0.Photos> getAllPhotos($0.Photo request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllPhotos, request, options: options);
  }
}

abstract class MemoryBookServiceBase extends $grpc.Service {
  $core.String get $name => 'proto.MemoryBookService';

  MemoryBookServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.User, $0.User>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.User>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Photo, $0.Photo>(
        'StorePhoto',
        storePhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Photo.fromBuffer(value),
        ($0.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Photo, $0.Photo>(
        'UpdatePhoto',
        updatePhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Photo.fromBuffer(value),
        ($0.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Photo, $0.Void>(
        'DeletePhoto',
        deletePhoto_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Photo.fromBuffer(value),
        ($0.Void value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Photo, $0.Photos>(
        'GetAllPhotos',
        getAllPhotos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Photo.fromBuffer(value),
        ($0.Photos value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> createUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return createUser(call, await request);
  }

  $async.Future<$0.User> login_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return login(call, await request);
  }

  $async.Future<$0.Photo> storePhoto_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Photo> request) async {
    return storePhoto(call, await request);
  }

  $async.Future<$0.Photo> updatePhoto_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Photo> request) async {
    return updatePhoto(call, await request);
  }

  $async.Future<$0.Void> deletePhoto_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Photo> request) async {
    return deletePhoto(call, await request);
  }

  $async.Future<$0.Photos> getAllPhotos_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Photo> request) async {
    return getAllPhotos(call, await request);
  }

  $async.Future<$0.User> createUser($grpc.ServiceCall call, $0.User request);
  $async.Future<$0.User> login($grpc.ServiceCall call, $0.User request);
  $async.Future<$0.Photo> storePhoto($grpc.ServiceCall call, $0.Photo request);
  $async.Future<$0.Photo> updatePhoto($grpc.ServiceCall call, $0.Photo request);
  $async.Future<$0.Void> deletePhoto($grpc.ServiceCall call, $0.Photo request);
  $async.Future<$0.Photos> getAllPhotos(
      $grpc.ServiceCall call, $0.Photo request);
}
