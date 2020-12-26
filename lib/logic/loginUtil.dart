/**
 * Check if a given String contain only numbers.
 */
bool checkUserPhoneInput(userPhoneFild){
  if (userPhoneFild == null) {
    return false;
  }
  return double.tryParse(userPhoneFild) != null;
}