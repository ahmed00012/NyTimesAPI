import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nytimes/generated/locale_keys.g.dart';
import 'package:nytimes/models/results.dart';
import 'package:translator/translator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;

class Details extends StatefulWidget {
  Results result;
  Details({this.result});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final translator = GoogleTranslator();

 @override
  void initState() {
   translator.translate(widget.result.title, from: 'en', to: 'ar').then(print);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.result.pic==null ?
        Row(children: [

          IconButton(onPressed:(){
            Navigator.pop(context);
          },
              icon:Icon(Icons.arrow_back,size: 25,)),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              width: 350,
              child: Text( 'NY TIMES MOST POPULAR BY BLOC',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                ),
                overflow: TextOverflow.ellipsis,),
            ),
          )
        ],)
           : Stack(
              children: [

                Image.network(
                  widget.result.pic,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.4 ,
                  fit:  BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
                Row(children: [

                  IconButton(onPressed:(){
Navigator.pop(context);
                  },
                      icon:Icon(Icons.arrow_back,color: Colors.white,size: 25,)),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Container(
                      width: 350,
                      child: Text( 'NY TIMES MOST POPULAR BY BLOC',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white
                        ),
                        overflow: TextOverflow.ellipsis,),
                    ),
                  )
                ],),
              ],
            ),


            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.result.title,
    maxLines: 2,
    style: TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold

    )          ),
            ),



            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.result.abstract,
              style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                        width:MediaQuery.of(context).size.width*0.8,
                        child: Text(LocaleKeys.created.tr()+' : '+ widget.result.byline,
                          maxLines: 2,

                          style: TextStyle(

                              fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),
                      ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text( LocaleKeys.source.tr()+' : ',
                    style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),
                 Text( widget.result.source,
                  style: TextStyle(fontSize: 18,color: Colors.black54,fontWeight: FontWeight.w500),),
              ]),
            ),

          ],
        ),
      ),

    );
  }
}
