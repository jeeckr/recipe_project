import 'package:logger/logger.dart';

final logger = Logger();

class CustomerPrinter extends LogPrinter {
  @override 
  List<String> log(LogEvent event) {
    final message = event.message;

    return [message];
  }
}
