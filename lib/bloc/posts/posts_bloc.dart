import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nytimes/models/results.dart';
import 'package:nytimes/repositories/posts_repository.dart';

import 'bloc.dart';



class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsRepository _postsRepository;

  PostsBloc({@required PostsRepository postsRepository})
      : assert(postsRepository!= null),
        _postsRepository = postsRepository, super(PostsInitialState());

  @override
  PostsState get initialState => PostsInitialState();

  @override
  Stream<PostsState> mapEventToState(
      PostsEvent event,
      ) async* {
    if (event is PostsStreamEvent) {
      yield* _mapStreamToState();
    }
  }

  Stream<PostsState> _mapStreamToState() async* {
    yield PostsLoadingState();
    List<Results> results= await _postsRepository.getPosts();
    yield PostsLoadedState(results: results );
  }
}