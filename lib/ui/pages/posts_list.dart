import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nytimes/bloc/authentication/authentication_bloc.dart';
import 'package:nytimes/bloc/authentication/bloc.dart';
import 'package:nytimes/bloc/posts/bloc.dart';
import 'package:nytimes/constants.dart';
import 'package:nytimes/repositories/authentication_repository.dart';
import 'package:nytimes/repositories/posts_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nytimes/ui/pages/home.dart';
import 'dart:ui' as ui;


import 'details.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  PostsBloc _postsBloc;
  AuthenticationBloc _authenticationBloc;

  PostsRepository postsRepository = PostsRepository();
AuthenticationRepository authenticationRepository = AuthenticationRepository();
  @override
  void initState() {

    _postsBloc = PostsBloc(postsRepository: postsRepository);
    _authenticationBloc= AuthenticationBloc(authenticationRepository: authenticationRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.locale);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: HexColor(color),
        title: Text('NY TIMES MOST POPULAR BY BLOC'),
        actions: [


          IconButton(
              onPressed: () {
                setState(() {
                  if(context.locale == Locale('en'))
                  context.locale = Locale('ar');
                  else
                  context.locale = Locale('en');
                });
    },
              icon: Icon(Icons.language,)),


          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              icon: Icon(Icons.logout,)),
        ],
      ),
      body: Center(
          child: BlocBuilder<PostsBloc, PostsState>(
        bloc: _postsBloc,
        builder: (context, state) {
          print(state.toString());
          if (state is PostsInitialState) {
            _postsBloc.add(PostsStreamEvent());
            return Center(
              child: CircularProgressIndicator(
                color: HexColor(color),
              ),
            );
          } else if (state is PostsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color:  HexColor(color),
              ),
            );
          } else if (state is PostsLoadedState)
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Details(result: state.results[index],)));
                  },
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            ClipOval(
                                child: state.results[index].pic == null
                                    ? Container(
                                        color: Colors.black38,
                                        width: 90,
                                        height: 90,
                                      )
                                    : Image.network(
                                        state.results[index].pic,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      )),
                            SizedBox(
                              width:MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              width:MediaQuery.of(context).size.width * 0.62,
                              child: Column(

                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      state.results[index].title,
                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width:MediaQuery.of(context).size.width * 0.6 ,
                                    child: Text(state.results[index].byline,
                                    style: TextStyle(
                                      color: Colors.black45,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),

                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(state.results[index].source,
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),),
                                      SizedBox(
                                        width:20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right:5),
                                        child: Icon(Icons.calendar_today_rounded,size: 15,),
                                      ),

                                      Text('  '+state.results[index].publishedDate ,
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_sharp,color: Colors.black54,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          return Container();
        },
      )),
    );
  }
}
