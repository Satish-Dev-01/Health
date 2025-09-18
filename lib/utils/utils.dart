
import 'package:intl/intl.dart';

String formatNumber(dynamic number) {
  if (number == null) return '0';

  final formatter = NumberFormat('#,###.##'); // handles int and double
  return formatter.format(number);
}