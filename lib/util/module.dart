import 'package:intl/intl.dart' as MyFormat;
import 'package:geocoding/geocoding.dart';

/// remove zero first in phone number
String removeZeroAtFirstDigitPhoneNumber(String inputPhoneNumber) {
  if (inputPhoneNumber.startsWith("0")) {
    return inputPhoneNumber.substring(1, inputPhoneNumber.length);
  }
  return inputPhoneNumber;
}

const String dateTimeFormat = "HH:mm, dd/MM/yyyy";
/// format date time to 'HH:mm, dd/MM/yyyy'
String formatDateTime(String dateTime) {
  return MyFormat.DateFormat(dateTimeFormat)
      .format(DateTime.parse((dateTime)).toLocal());
}

String formatTimeToHour(String time) {
  return MyFormat.DateFormat('HH:mm a').format(DateTime.parse((time)).toLocal());
}

String getAddressFromPlaceCheckIn(Placemark place) {
  return ((place.street.toString().isNotEmpty)
      ? '${place.street.toString()}, '
      : '') +
      ((place.subAdministrativeArea.toString().isNotEmpty)
          ? '${place.subAdministrativeArea.toString()}, '
          : '') +
      ((place.administrativeArea.toString().isNotEmpty)
          ? '${place.administrativeArea.toString()}, '
          : '') +
      ((place.country.toString().isNotEmpty)
          ? '${place.country.toString()}, '
          : '');
}

String getAddressFromPlaceUserLocation(Placemark place) {
  return ((place.subAdministrativeArea.toString().isNotEmpty)
          ? '${place.subAdministrativeArea.toString()}, '
          : '') +
      ((place.administrativeArea.toString().isNotEmpty)
          ? '${place.administrativeArea.toString()}, '
          : '') +
      ((place.country.toString().isNotEmpty)
          ? '${place.country.toString()}, '
          : '');
}

/// Condition to check the email address
bool checkEmailAddress(String newEmail) {
  if (newEmail.isNotEmpty) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(newEmail);
  }
  return false;
}
