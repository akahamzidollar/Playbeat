import 'package:form_field_validator/form_field_validator.dart';

final emailValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'required!'),
    EmailValidator(
      errorText: 'Please enter a valid email',
    ),
  ],
);

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'Required!'),
    MinLengthValidator(8, errorText: 'password must be 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'one special character required!')
  ],
);

final confirmPasswordValidator =
    MatchValidator(errorText: 'your password is not matching');

final requiredValidator = RequiredValidator(errorText: 'Required');
