// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';

// class MyConnectivity {
//   MyConnectivity._internal();

//   static final MyConnectivity _instance = MyConnectivity._internal();

//   static MyConnectivity get instance => _instance;

//   Connectivity connectivity = Connectivity();

//   final StreamController<dynamic> controller =
//       StreamController<dynamic>.broadcast();

//   Stream<dynamic> get myStream => controller.stream;

//   Future<void> initialise() async {
//     final ConnectivityResult result = await connectivity.checkConnectivity();
//     _checkStatus(result);
//     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _checkStatus(result);
//     });
//   }

//   Future<void> _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final List<InternetAddress> result =
//           await InternetAddress.lookup('https://www.google.com/');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isOnline = true;
//       } else {
//         isOnline = false;
//       }
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     // ignore: always_specify_types
//     final dynamic data = {result: isOnline};
//     controller.sink.add(data);
//   }

//   void disposeStream() => controller.close();

//   Future<bool> checkConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }
// }
