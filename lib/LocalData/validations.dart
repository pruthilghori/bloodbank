String validName(String value) {
  String pattern = r'^[a-zA-Z ]+$';
  RegExp regex = new RegExp(pattern);
  // return (!regex.hasMatch(name)) ? false : true;
  return (value.isEmpty)
      ? "Enter Your Name"
      : !regex.hasMatch(value)
          ? "Enter a valid name"
          : '';
}

String validEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return "* Required";
  } else if (!regex.hasMatch(value)) {
    return "Invalid Email";
  } else {
    // Check if the email domain is ".gmail.com"
    String domain = value.split('@').last;
    if (domain != 'gmail.com') {
      return "Only emails with domain '.gmail.com are accepted";
    }
    return '';
  }
}

String validAddress(String value) {
  String pattern = r'^[a-zA-Z0-9 ,-]+$';
  RegExp reget = new RegExp(pattern);
  return (value.toString().isEmpty)
      ? "Please Enter Address"
      : !reget.hasMatch(value)
          ? "Enter a valid Address"
          : '';
}

String validPhoneNo(String value) {
  String pattern = r'^[0-9]+$';
  RegExp reget = new RegExp(pattern);
  return (value.toString().isEmpty)
      ? 'Please Enter Value in PhoneNo'
      : !reget.hasMatch(value)
          ? 'Enter a valid Phone No'
          : value.length != 10
              ? 'Enter 10 Character phone no'
              : '';
}

String validGender(String value) {
  return (value.isEmpty) ? 'Please Select Gender' : '';
}

String validBloodGroup(String value) {
  if ((value == null)) {
    return 'Please Select Blood Group';
  } else {
    return '';
  }
}

String validWeight(String value) {
  return (value == "50.0") ? 'Please Select Weight' : '';
}

String validAge(String value) {
  if ((value == "18.0")) {
    return 'Please Select Age';
  } else {
    return '';
  }
}

String validRadio(String value) {
  return (value.isEmpty) ? 'Please Select Any one' : '';
}

String validPassword(String value) {
  return (value.toString().isEmpty)
      ? "Please Enter Password"
      : value.length < 6
          ? "password must be 6 Character"
          : '';
}
