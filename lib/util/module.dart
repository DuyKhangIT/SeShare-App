/// remove zero first in phone number
String removeZeroAtFirstDigitPhoneNumber(String inputPhoneNumber){
  if (inputPhoneNumber.startsWith("0")) {
    return inputPhoneNumber.substring(1, inputPhoneNumber.length);
  }
  return inputPhoneNumber;
}