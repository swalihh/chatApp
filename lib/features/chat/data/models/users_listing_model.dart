import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_listing_model.g.dart';

@JsonSerializable()
class UsersListingModel extends Equatable {
    const UsersListingModel({
        required this.users,
    });

    final List<User>? users;

    factory UsersListingModel.fromJson(Map<String, dynamic> json) => _$UsersListingModelFromJson(json);

    Map<String, dynamic> toJson() => _$UsersListingModelToJson(this);

    @override
    List<Object?> get props => [
    users, ];
}

@JsonSerializable()
class User extends Equatable {
    const User({
        required this.name,
        required this.profileImage,
    });

    final String? name;

    @JsonKey(name: 'profile_image') 
    final String? profileImage;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);

    @override
    List<Object?> get props => [
    name, profileImage, ];
}
