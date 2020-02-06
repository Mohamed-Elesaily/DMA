import 'package:example_flutter/ram/ram.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dma/dma.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
 
  runApp(
  new MyApp()

  );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context)=> DMA(),
          '/ram':(context)=> Ram(),
          
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        title: 'DMA',
      
        );
  }
}
