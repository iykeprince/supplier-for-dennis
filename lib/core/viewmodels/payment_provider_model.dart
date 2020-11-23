import 'package:uplanit_supplier/core/models/default_response.dart';
import 'package:uplanit_supplier/core/models/payment_provider/stripe_response.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/payment_provider_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class PaymentProviderModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  PaymentProviderService _paymentProviderService =
      locator<PaymentProviderService>();

  bool _isConnectStripe;
  String _errorMessage;
  bool _connectingStripe = false;

  bool get isConnectStripe => _isConnectStripe;
  String get errorMessage => _errorMessage;
  bool get connectingStripe => _connectingStripe;

  PaymentProviderModel() {
    getStripeDetail();
  }

  void setConnectingStripe(bool connectingStripe) {
    _connectingStripe = connectingStripe;
    notifyListeners();
  }

  void setErrorMessage(errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void connectStripe() {
    _isConnectStripe = true;
    notifyListeners();
  }

  void disconnectStripe() {
    _isConnectStripe = false;
    notifyListeners();
  }

  Future<DefaultResponse> addStripeDetail(String code) async {
    String token = await auth.user.getIdToken();
    return await _paymentProviderService.addStripeDetail(
      code: code,
      token: token,
    );
  }

  void getStripeDetail() async {
    String token = await auth.user.getIdToken();
    StripeResponse stripeResponse =
        await _paymentProviderService.getStripeDetail(token: token);
    if (stripeResponse != null && stripeResponse.stripeUserId != null) {
      _isConnectStripe = true;
    } else {
      _isConnectStripe = false;
    }
    notifyListeners();
  }

  Future<DefaultResponse> deleteStripeConnect() async {
    String token = await auth.user.getIdToken();
    return await _paymentProviderService.deleteStripeConnect(token: token);
  }
}
