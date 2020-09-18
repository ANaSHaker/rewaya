import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:native_pdf_view/native_pdf_view.dart';


class HomePage extends KFDrawerContent {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> _colorAnim;
  int _actualPageNumber = 1, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset("assets/mypdf.pdf"),
    );

    controller = AnimationController(duration: Duration(seconds: 3), vsync: this);
    _colorAnim = ColorTween(begin: Colors.cyan,end: Colors.green)
        .animate(controller)
      ..addListener(() { setState(() {}); })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("الجنون في القنينة",
          style: TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading:   IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: widget.onMenuPressed,),
        actions: [
          Visibility(
              visible: true,
              child: AvatarGlow(
                animate: true,
                endRadius: 45.0,
                showTwoGlows: true,
                duration: const Duration(milliseconds:1500),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child:  IconButton(
                  icon: Icon(Icons.navigate_before,color: _colorAnim.value,),
                  onPressed: () {
                    _pdfController.previousPage(
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 100),
                    );
                  },
                ),)),

          Visibility(
            visible: true,
            child: AvatarGlow(
              animate: true,
              endRadius: 45.0,
              showTwoGlows: true,
              duration: const Duration(milliseconds:1500),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: IconButton(
                icon: Icon(Icons.navigate_next,color: _colorAnim.value,),
                onPressed: () {
                  _pdfController.nextPage(
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 100),
                  );
                },
              ),),
          ),
        ],



      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(bottom:55.0),
        child: FloatingActionButton.extended(
            backgroundColor: _colorAnim.value,
            icon: const Icon(Icons.add),
            label: Text('$_actualPageNumber / $_allPagesCount',),
            onPressed: (){}
            ),
      ),
        body:  PdfView(
          documentLoader: Center(child: CircularProgressIndicator()),
          pageLoader: Center(child: CircularProgressIndicator()),
          controller: _pdfController,
          onDocumentLoaded: (document) {
            setState(() {
              _actualPageNumber = 1;
              _allPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              _actualPageNumber = page;
            });
          },
        ),


    );
  }
}



