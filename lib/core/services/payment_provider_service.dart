import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/default_response.dart';
import 'package:uplanit_supplier/core/models/payment_provider/stripe_response.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class PaymentProviderService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<DefaultResponse> addStripeDetail({String code, String token}) async {
    print(
        '===========================ADD STRIPE DETAIL================================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: '/vendor/account/payment/stripe/$code?state=k204E8qjzD',
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return defaultResponseFromJson('{"name": "SUCCESS", "message": "Connected to stripe"}');
      } else if (response.statusCode == 501) {
        return defaultResponseFromJson(response.body);
      } else if (response.statusCode == 401) {
        return defaultResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
      return null;
    }
  }

  Future<StripeResponse> getStripeDetail({String token}) async {
    print(
        '===========================GET STRIPE DETAIL================================');

    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_STRIPE_DETAIL,
        token: token,
      );

      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return stripeResponseFromJson(response.body);
      } else if (response.statusCode == 404) {
        return null;
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
      return null;
    }
  }

  Future<DefaultResponse> deleteStripeConnect({String token}) async {
    print(
        '===========================DELETE STRIPE DETAIL================================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.DELETE,
        path: ApiEndpoint.DELETE_STRIPE_CONNECT,
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 201) {
        return defaultResponseFromJson(response.body);
      } else if (response.statusCode == 501) {
        return defaultResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
      return null;
    }
  }
}
