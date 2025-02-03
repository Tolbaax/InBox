import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetPostsParams extends Equatable {
  final int limit;
  final DocumentSnapshot startAfter;

  const GetPostsParams({required this.limit, required this.startAfter});

  @override
  List<Object?> get props => [limit, startAfter];
}
