// part of 'extension.dart';

// extension ExtBuildContext on BuildContext {
//   ThemeData get theme => Theme.of(this);

//   double get height => MediaQuery.of(this).size.height;

//   double get width => MediaQuery.of(this).size.width;

//   void showError(String message,
//       {Duration? duration, FlushbarStatusCallback? onStatusChanged}) {
//     HapticFeedback.heavyImpact();
//     Flushbar(
//       title: 'Error!',
//       message: message,
//       duration: duration ?? const Duration(seconds: 2),
//       backgroundColor: Colors.red,
//       titleColor: Colors.white,
//       messageColor: Colors.white,
//       flushbarPosition: FlushbarPosition.TOP,
//       onStatusChanged: onStatusChanged,
//     ).show(this);
//   }

//   void showSuccess(String message,
//       {Duration? duration, FlushbarStatusCallback? onStatusChanged}) {
//     HapticFeedback.heavyImpact();
//     Flushbar(
//       title: 'Success!',
//       message: message,
//       duration: duration ?? const Duration(seconds: 2),
//       backgroundColor: Colors.green,
//       titleColor: Colors.white,
//       messageColor: Colors.white,
//       flushbarPosition: FlushbarPosition.TOP,
//       onStatusChanged: onStatusChanged,
//     ).show(this);
//   }

//   void showInfo(String message,
//       {Duration? duration, FlushbarStatusCallback? onStatusChanged}) {
//     HapticFeedback.heavyImpact();
//     Flushbar(
//       title: 'Information!',
//       message: message,
//       duration: duration ?? const Duration(seconds: 2),
//       backgroundColor: Colors.red,
//       titleColor: Colors.white,
//       messageColor: Colors.white,
//       flushbarPosition: FlushbarPosition.TOP,
//       onStatusChanged: onStatusChanged,
//     ).show(this);
//   }
// }
