import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class CustomBrowser extends StatefulWidget {
  CustomBrowser({Key key}) : super(key: key);

  @override
  _CustomBrowserState createState() => _CustomBrowserState();
}

class _CustomBrowserState extends State<CustomBrowser> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  var check2 =
      'https://supplier.uplanit.co.uk/account/payment_providers/stripe';
  var check = 'http://localhost:4200/account/payment_providers/stripe';
  var target = "_blank";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void stopLoading() async {
  //   if (webView != null) {
  //     await webView.();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.cancel_sharp,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect Stripe Account',
              style: GoogleFonts.workSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '$url',
              style: GoogleFonts.workSans(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Colors.black12,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: progress,
              height: 5,
              decoration: BoxDecoration(
                color: CustomColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: InAppWebView(
          initialUrl:
              "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_CHloZVGHO9fVH8vkRqmmKByfT2lMOSZa&scope=read_write&state=k204E8qjzD",
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
            debuggingEnabled: true,
          )),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            print('onLoading nice coming along: $url');
            setState(() {
              this.url = url;
            });
            if (url.indexOf(check) == 0 || url.indexOf(check2) == 0) {
              String code = this.getCodeFromUrl(url);
              Navigator.pop(context, code);
            } 
          },
          onLoadStop: (InAppWebViewController controller, String url) async {
            print('onLoadStop: $url');
            setState(() {
              this.url = url;
            });
            
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            print('progress: $progress');
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      ),
    );
  }

  String getCodeFromUrl(url) {
    var response = url.split('?')[1].split('&');
    var scope = response[1];
    var code = response[2];
    print('url response: $response');

    if (isAccepted(scope)) {
      print('scope is accepted');
      // this.note.push(code.split('=')[1])
      // this.sendDetailsToDb(code.split('=')[1]);
      return code;
    } else {
      print('not accepted scope');
      // this.note.push('pass test')
      // this.note.push(code.split('=')[1])
      // presentToast('You\'ve rejected our connection request. If you wish to connect again, tap connect with stripe button');
      return null;
    }
  }

  bool isAccepted(String scope) {
    if (scope.split('=')[0] == 'scope') {
      return true;
    }

    return false;
  }
}
