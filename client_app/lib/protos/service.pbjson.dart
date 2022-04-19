///
//  Generated code. Do not modify.
//  source: service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use voidDescriptor instead')
const Void$json = const {
  '1': 'Void',
};

/// Descriptor for `Void`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voidDescriptor = $convert.base64Decode('CgRWb2lk');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'secretCode', '3': 3, '4': 1, '5': 9, '10': 'secretCode'},
    const {'1': 'emailAddress', '3': 4, '4': 1, '5': 9, '10': 'emailAddress'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgFUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEh4KCnNlY3JldENvZGUYAyABKAlSCnNlY3JldENvZGUSIgoMZW1haWxBZGRyZXNzGAQgASgJUgxlbWFpbEFkZHJlc3M=');
@$core.Deprecated('Use usersDescriptor instead')
const Users$json = const {
  '1': 'Users',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.proto.User', '10': 'users'},
  ],
};

/// Descriptor for `Users`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List usersDescriptor = $convert.base64Decode('CgVVc2VycxIhCgV1c2VycxgBIAMoCzILLnByb3RvLlVzZXJSBXVzZXJz');
@$core.Deprecated('Use photoDescriptor instead')
const Photo$json = const {
  '1': 'Photo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'byteCode', '3': 2, '4': 1, '5': 12, '10': 'byteCode'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'dateOfCreation', '3': 4, '4': 1, '5': 9, '10': 'dateOfCreation'},
    const {'1': 'location', '3': 5, '4': 1, '5': 9, '10': 'location'},
    const {'1': 'secretCode', '3': 6, '4': 1, '5': 9, '10': 'secretCode'},
  ],
};

/// Descriptor for `Photo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoDescriptor = $convert.base64Decode('CgVQaG90bxIOCgJpZBgBIAEoBVICaWQSGgoIYnl0ZUNvZGUYAiABKAxSCGJ5dGVDb2RlEiAKC2Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbhImCg5kYXRlT2ZDcmVhdGlvbhgEIAEoCVIOZGF0ZU9mQ3JlYXRpb24SGgoIbG9jYXRpb24YBSABKAlSCGxvY2F0aW9uEh4KCnNlY3JldENvZGUYBiABKAlSCnNlY3JldENvZGU=');
@$core.Deprecated('Use photosDescriptor instead')
const Photos$json = const {
  '1': 'Photos',
  '2': const [
    const {'1': 'photos', '3': 1, '4': 3, '5': 11, '6': '.proto.Photo', '10': 'photos'},
  ],
};

/// Descriptor for `Photos`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photosDescriptor = $convert.base64Decode('CgZQaG90b3MSJAoGcGhvdG9zGAEgAygLMgwucHJvdG8uUGhvdG9SBnBob3Rvcw==');
