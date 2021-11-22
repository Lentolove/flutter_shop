import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class WebViewPage extends StatefulWidget {

  final String bannerName;
  final String bannerDetailUrl;


  const WebViewPage({Key? key,required this.bannerName,required this.bannerDetailUrl}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         children: [
           AppBar(
             title: Text(widget.bannerName),
             centerTitle: true,
           ),
           Expanded(
             child: WebView(
               initialUrl: widget.bannerDetailUrl,
               javascriptMode: JavascriptMode.unrestricted,
               gestureNavigationEnabled: true,
               onWebViewCreated: (WebViewController webViewController) {
                 _controller.complete(webViewController);
               },
               onProgress: (int progress) {
                 print("WebView is loading (progress : $progress%)");
               },
               navigationDelegate: (NavigationRequest request) {
                 return NavigationDecision.navigate;
               },
               onPageStarted: (String url) {
                 print('Page started loading: $url');
               },
               onPageFinished: (String url) {
                 print('Page finished loading: $url');
               },
             ),
           )
         ],
       ),
    );
  }

  ///定义WebView 导航栏
  Widget _appBar(Color backGroundColor, Color backButtonColor) {
    return Container(
      color: backGroundColor,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.bannerName,
                  style: TextStyle(color: backGroundColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
