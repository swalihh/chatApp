import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/chat/data/models/users_listing_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UsersListingModel>> getAllUsers();
}
