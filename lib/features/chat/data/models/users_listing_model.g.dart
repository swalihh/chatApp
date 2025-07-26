// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListingModel _$UsersListingModelFromJson(Map<String, dynamic> json) =>
    UsersListingModel(
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$UsersListingModelToJson(UsersListingModel instance) =>
    <String, dynamic>{'users': instance.users};

User _$UserFromJson(Map<String, dynamic> json) => User(
  name: json['name'] as String?,
  profileImage: json['profile_image'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'name': instance.name,
  'profile_image': instance.profileImage,
};
