import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/business_profile/address.dart';
import 'package:uplanit_supplier/core/models/business_profile/address_response.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_work_time.dart';
import 'package:uplanit_supplier/core/models/category.dart';
import 'package:uplanit_supplier/core/models/business_profile/contact.dart';
import 'package:uplanit_supplier/core/models/business_profile/country.dart';
import 'package:uplanit_supplier/core/models/business_profile/cover_image.dart';
import 'package:uplanit_supplier/core/models/event_type.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_category.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_cover_image.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_event_type.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_logo.dart';
import 'package:uplanit_supplier/core/models/business_profile/week_day.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_work_time.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class BusinessProfileService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<BaseProfile> getBaseProfile({@required String token}) async {
    debugPrint('token: $token');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_BASE_PROFILE,
        token: token,
      );

      if (response.statusCode == 200) {
        return baseProfileFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
      return null;
    }
  }

  Future<BaseUserProfile> updateProfile({
    @required BaseUserProfile baseUserProfile,
    String token,
  }) async {
    print('base user profile: ${baseUserProfileToJson(baseUserProfile)}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_BASE_PROFILE,
        parameter: baseUserProfileToJson(baseUserProfile),
        token: token,
      );
      print('status code: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return baseUserProfileFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  //create contact
  Future<Contact> createContact(
      {@required String token, @required Contact contact}) async {
    try {
      var response = await apiRepository.request(
          requestType: RequestType.PUT,
          path: ApiEndpoint.CREATE_CONTACT,
          token: token,
          parameter: contactToJson(contact));
      print('body: ${response.body}');
      print('status: ${response.statusCode}');
      return contactFromJson(response.body);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  //update contact
  Future<Contact> updateContact({@required User user, Contact contact}) async {
    String token = await user.getIdToken();
    try {
      var response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_CONTACT,
        token: token,
        parameter: contactToJson(contact),
      );
      return contactFromJson(response.body);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  Future<List<Country>> getCountries() async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_COUNTRIES,
      );
      return countryFromJson(response.body);
    } catch (e) {
      print('Network Error: ${e.message}');
      return [];
    }
  }

  Future<List<Category>> getCategories({@required User user}) async {
    String token = await user.getIdToken();
    print('token: $token');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_SUPPLIER_CATEGORIES,
        token: token,
      );
      print('body: ${response.body}');
      return categoryFromJson(response.body);
    } catch (e) {
      print('Network Error: ${e.message}');
      throw e;
    }
  }

  Future<List<Category>> updateSupplierCategory({
    PostCategory postCategories,
    String token,
  }) async {
    print('body: ${postCategoryToJson(postCategories)}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_SUPPLIER_CATEGORIES,
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

  Future<List<EventType>> updateEventType({
    PostEventType postEventType,
    String token,
  }) async {
    print('updating event type');
    print('data: ${postEventType.toJson()}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_EVENT_TYPES,
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

  //create Address
  Future<AddressResponse> createAddress({
    Address address,
    String token,
  }) async {
    try {
      final response = await apiRepository.request(
          requestType: RequestType.PUT,
          path: ApiEndpoint.CREATE_PROFILE_ADDRESS,
          token: token,
          parameter: addressToJson(address));
      if (response.statusCode == 200) {
        print('Create Address: returned body: ${response.body}');
        return addressResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
    }
  }

  //update address
  Future<AddressResponse> updateAddress({Address address, String token}) async {
    try {
      final response = await apiRepository.request(
          requestType: RequestType.POST,
          path: ApiEndpoint.UPDATE_PROFILE_ADDRESS,
          token: token,
          parameter: addressToJson(address));

      print('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('body: ${response.body}');
        return addressResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.toString()}');
      return null;
    }
  }

  //update work time
  Future<List<BaseWorkTime>> updateWorkTime({
    PostWorkTime workTimeObject,
    String token,
  }) async {
    print('body: ${workTimeToJson(workTimeObject)}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_WORK_HOURS,
        parameter: workTimeToJson(workTimeObject),
        token: token,
      );
      print('response status: ${response.statusCode}');
      print('response body: ${response.body}');
      if (response.statusCode == 200) {
        return baseWorkTimeFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.message}');
    }
  }

  //get days of the week
  Future<List<WeekDay>> getWeekDays({
    String token,
  }) async {
    try {
      print('GET WEEK DAYS');
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_WORK_DAYS,
        token: token,
      );
      if (response.statusCode == 200) {
        return weekDayFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.message}');
    }
  }

  //get file upload url
  Future<String> getFileUploadURL({
    @required User user,
    @required String dynamicURL,
  }) async {
    String token = await user.getIdToken();
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: dynamicURL,
        token: token,
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  //upload to s3
  Future<String> uploadFileToS3({
    @required String url,
    @required File file,
  }) async {
    try {
      final response = await apiRepository.requestFile(
        requestType: RequestType.UPLOAD_IMAGE,
        path: url,
        file: file,
      );
      return response;
    } catch (e) {
      print('s3 Network error: ${e.message}');
      return "";
    }
  }

  //update cover image
  Future<CoverImage> updateCoverImage({
    @required PostCoverImage postCoverImage,
    @required User user,
  }) async {
    try {
      String token = await user.getIdToken();
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_COVER_IMAGE,
        parameter: postCoverImageToJson(postCoverImage),
        token: token,
      );
      return coverImageFromJson(response.body);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  //update logo
  Future<CoverImage> updateLogo({
    @required LogoImage postLogoImage,
    @required User user,
  }) async {
    try {
      String token = await user.getIdToken();
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_LOGO_IMAGE,
        parameter: logoImageToJson(postLogoImage),
        token: token,
      );
      return coverImageFromJson(response.body);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }
}
