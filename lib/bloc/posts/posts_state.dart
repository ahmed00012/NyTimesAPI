
import 'package:equatable/equatable.dart';
import 'package:nytimes/models/results.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
List<Results> results;
PostsLoadedState({this.results});


}