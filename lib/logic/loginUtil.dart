/**
 * Check if a given String contain only numbers.
 */
bool checkUserPhoneInput(userPhoneFild){
  if(userPhoneFild.length > 10)
    return false;
  if (userPhoneFild == null) {
    return false;
  }
  return double.tryParse(userPhoneFild) != null;
}
