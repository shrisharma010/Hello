import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants.dart';

class Utility {
  static toast(String m) => ScaffoldMessenger.of(Get.context!)
      .showSnackBar(SnackBar(content: Text(m)));

  static errorToast(String m) => ScaffoldMessenger.of(Get.context!)
      .showSnackBar(SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              m,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
      ))
      .toString();
  static favouriteToast(String m) => ScaffoldMessenger.of(Get.context!)
      .showSnackBar(SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              m,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        duration: Duration(seconds: 2),
      ))
      .toString();

  static Widget internetManagerWidget(Widget child) {
    return FutureBuilder(
      future: InternetConnectionChecker().hasConnection,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data == true) {
          return child;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: mJeskieBGThemeColor,
            appBar:  AppBar(
              backgroundColor: mJeskieBGThemeColor,
                elevation: 0,
              leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage("assets/images/nonet.webp")),
                    SizedBox(height: 20),
                    const Text("Failed to connect 😭",
                        style: TextStyle(color: Colors.grey,fontSize: 16)),
                    // const SizedBox(height: 10),
                    // RaisedButton(
                    //     color: Colors.red,
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(10),
                    //       child: Text("Refresh",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 17,
                    //               fontWeight: FontWeight.bold)),
                    //     ),
                    //     onPressed: () => onRefresh())
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  static Widget checkInternetManagerWidget(Widget child,Function onRefresh) {
    return FutureBuilder(
      future: InternetConnectionChecker().hasConnection,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data == true) {
          return child;
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Image(image: AssetImage("assets/images/nonet.webp")),
                const SizedBox(height: 20),
                const Text("Failed to connect ",
                    style: TextStyle(color: Colors.grey,fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffFAF9F6)
                    ),
                    child:  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Retry",
                          style: TextStyle(
                              color: mJeskieBGThemeColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () => onRefresh())
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

}
