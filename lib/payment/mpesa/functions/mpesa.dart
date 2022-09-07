import 'package:mpesa/mpesa.dart';
import 'package:saccofy/payment/models/deposit_funds_model.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

String? passCode =
    'BtL3PNVRHGRV132/nCb0fPcX4KSrZF49N8PqubpXgF2ibC89sOfpkNnxXO7eyj1egX+SR9ReGO1BqcMhLedzahcWvbgdTe3PzaXiEKp3hgRGQIB3chQWByw/6i3XBZo78zUrh66LdDVGnGJ9yxlh7U4lzaAjcZcgtRwiH45N00W2kMafY/AL7FbbFu2U+0lu0tuH1jUJ/u4nYem4h32DpvCd8lUaFsG8H/g0xL4rqQC2mwXzYCsGYZG8N8lxKUdvpXBMv3+1DyffyMLHM+cSL6UViPYGk5syYwnC+BodVvfEpqw+aMktw+HGKgcJGIs+SL9Kmkk51DWXadSbjX+PmQ==';

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
