import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/category.dart';
import 'package:uplanit_supplier/core/models/event_type.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_category.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_event_type.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class OnboardService {
  AuthenticationService auth = locator<AuthenticationService>();
  ApiRepository apiRepository = locator<ApiRepository>();

  StreamController<Onboard> _onboardStreamController =
      BehaviorSubject<Onboard>();

  Stream<Onboard> get onboardStream => _onboardStreamController.stream;
  StreamSink<Onboard> get onboardSink => _onboardStreamController.sink;

  dispose() {
    _onboardStreamController.close();
  }

  checkOnboard() async {
    if (auth.user != null) {
      print('checking on board with user found');
      try {
        String token = await auth.user.getIdToken();

        print('data is ready');

        final response = await apiRepository.request(
          requestType: RequestType.GET,
          path: ApiEndpoint.CHECK_ONBOARD,
          token: token,
        );
        print('checkonboard ready: ${response.statusCode}');
        print('body: ${response.body}');
        if (response.statusCode == 200) {
          return onboardFromJson(response.body);
        }
      } catch (e) {
        print(e.message);
        return null;
      }
    }
    print('user not found');
    return null;
  }

  Future<Profile> createProfile({
    Profile body,
    String token,
  }) async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_PROFILE,
        parameter: profileToJson(body),
        token: token,
      );

      if (response.statusCode == 200) {
        return profileFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('profile error: ${e.message}');
      return null;
    }
  }

  Future<List<Category>> getCategories({@required User user}) async {
    String token = await user.getIdToken();
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.CATEGORIES,
        token: token,
      );
      print('status code: ${response.statusCode}');
      print('body: ${response.body}');
      return categoryFromJson(response.body);
    } catch (e) {
      print('Network Error: ${e.message}');
    
    }
  }

  Future<List<Category>> createCategory({
    PostCategory postCategories,
    String token,
  }) async {
    print('body: ${postCategoryToJson(postCategories)}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_CATEGORY,
        token: token,
        parameter: postCategoryToJson(postCategories),
      );

      if (response.statusCode == 200) {
        return categoryFromJson(response.body);
      }
      return [];
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

  Future<List<EventType>> getEventTypes({@required User user}) async {
    String token = await user.getIdToken();
    print('token: $token');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.EVENT_TYPES,
        token: token,
      );
      print('statusCode: ${response.statusCode}');
      if (response.statusCode == 200) {
        return eventTypeFromJson(response.body);
      }
      return [];
    } catch (e) {
      print('Network Error: ${e.message}');
      return [];
    }
  }

  Future<List<EventType>> createEventType({
    PostEventType postEventType,
    String token,
  }) async {
    print('data: ${postEventType.toJson()}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_EVENT_TYPE,
        token: token,
        parameter: postEventTypeToJson(postEventType),
      );
      print('status code: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return eventTypeFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('error $e');
      return null;
    }
  }
}
