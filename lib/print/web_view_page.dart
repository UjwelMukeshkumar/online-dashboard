// import 'package:flutter/material.dart';

// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     WebViewController _controller;
//     return SafeArea(
//       child: WebView(
//         initialUrl:
//             'https://print.glowsis.com/p?t=7-468-75AOT4DM9AODBOT9821KIBTZCY5YLDDKB8MXEW1S6JBYK1WHU6',
//         javascriptMode: JavascriptMode.unrestricted,
//         // gestureNavigationEnabled: true,
//         // zoomEnabled: true,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//         onWebResourceError: (erro) {
//           print("Error $erro");
//         },
//         allowsInlineMediaPlayback: true,
//         debuggingEnabled: true,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  late WebViewController _controller;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("TutorialKart - Flutter WebView"),
        ),
        body: Center(
          child: WebView(
            initialUrl: 'https://www.tutorialkart.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
        ),
      ),
    );
  }
}
