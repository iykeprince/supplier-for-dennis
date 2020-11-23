import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/repository/api.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';

class OnboardBloc {
  OnboardService _onboardService;

  StreamController _onboardServiceController;

  StreamSink<ApiResponse<Onboard>> get onboardServiceSink =>
      _onboardServiceController.sink;

  Stream<ApiResponse<Onboard>> get onboardServiceStream =>
      _onboardServiceController.stream;

  OnboardBloc() {
    _onboardServiceController = BehaviorSubject<ApiResponse<Onboard>>();
    _onboardService = OnboardService();
    fetchOnboard();
  }

  fetchOnboard() async {
    onboardServiceSink.add(ApiResponse.loading("fetching onboard..."));
    try {
      print('fetching');
      Onboard onboard = await _onboardService.checkOnboard();

      onboardServiceSink.add(ApiResponse.completed(onboard));
    } catch (e) {
      onboardServiceSink.add(ApiResponse.error(e.toString()));
    }
  }

dispose(){
  _onboardServiceController?.close();
}
}
