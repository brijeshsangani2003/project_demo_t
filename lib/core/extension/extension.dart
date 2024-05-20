// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'package:shimmer/shimmer.dart';

extension StringExtensions on String {
  /// Print Devlopement Logs
  void printLog() {
    if (kDebugMode) log('===> $this');
  }

  /// Save to clipboard
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this));
  }

  /// Get FileName
  String fileName() {
    return contains('/') ? split('/').last : '';
  }

  /// Get File Extension
  String fileType() {
    return contains('/') ? split('.').last : '';
  }

  /// manage https://
  String manageUrl() {
    return !contains('https://') && !contains('http://')
        ? 'https://$this'
        : this;
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

// extension WidgetExtensions on Widget {
//   Widget toShimmer() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.withOpacity(0.1),
//       highlightColor: Colors.grey.withOpacity(0.18),
//       child: this,
//     );
//   }
// }
extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

/// MAP With Async
extension AsyncMap<K, V> on Map<K, V> {
  Future<void> forEachAsync(FutureOr<void> Function(K, V) fun) async {
    for (var value in entries) {
      final k = value.key;
      final v = value.value;
      await fun(k, v);
    }
  }
}

/// Calculate code execution time
Stopwatch stopwatch = Stopwatch();

enum DevExecutionTime { start, stop, reset }

/// usage:
/// executeTimeWatch(devExecutionTime: DevExecutionTime.reset);
/// executeTimeWatch(devExecutionTime: DevExecutionTime.start);
void executeTimeWatch({required DevExecutionTime devExecutionTime}) {
  switch (devExecutionTime) {
    case DevExecutionTime.start:
      stopwatch.start();
      break;
    case DevExecutionTime.stop:
      'Execution time in seconds: ${stopwatch.elapsedMilliseconds}'.printLog();
      stopwatch.stop();
      break;
    case DevExecutionTime.reset:
      stopwatch.reset();
      break;
  }
}
