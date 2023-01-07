import 'package:mpesa/mpesa.dart';
import 'package:saccofy/payment/models/deposit_funds_model.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

// AuthNotifier? authNotifier;

class GetMpesaSTK extends DepositFundsToSacco {
  Mpesa? stk = Mpesa(
    clientKey: "ZngCJbL3AZhk1e0AwtSDkpapdfY28ohM",
    clientSecret: "69P27qgfKP9EUkfW",
    passKey: passCode.toString(),
    environment: "sandbox",
  );

  deposit() {
    stk!
        .lipaNaMpesa(
          phoneNumber: 'authNotifier!.user!.phoneNumber.toString()',
          amount: 1,
          callbackUrl: '',
          businessShortCode: '12356',
        )
        .then((value) => null);
  }
}
