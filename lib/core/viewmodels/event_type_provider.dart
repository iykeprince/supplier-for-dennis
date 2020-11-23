import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/event_type.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_event_type.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class EventTypeProvider extends BaseModel {
  OnboardService onboardService = OnboardService();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();
  AuthenticationService auth = locator<AuthenticationService>();
  List<EventType> _eventTypeList = [];
  List<EventType> _selectedEventTypeList = [];

  List<EventType> get eventTypeList => _eventTypeList;
  List<EventType> get selectedEventTypeList => _selectedEventTypeList;

  Future<List<EventType>> createEventType() async {
    String token = await auth.user.getIdToken();
    PostEventType postEventType = PostEventType(
        eventTypes:
            List<String>.from(selectedEventTypeList.map<String>((e) => e.id))
                .toList());

    return onboardService.createEventType(
      postEventType: postEventType,
      token: token,
    );
  }

  Future<List<EventType>> updateEventType() async {
    String token = await auth.user.getIdToken();
    PostEventType postEventType = PostEventType(
        eventTypes:
            List<String>.from(selectedEventTypeList.map<String>((e) => e.id))
                .toList());

    return _businessProfileService.updateEventType(
      postEventType: postEventType,
      token: token,
    );
  }

  void addSelected(int index) {
    EventType eventType = _eventTypeList[index];

    eventType.selected = !eventType.selected;
    print('toggled');

    List<EventType> list = _selectedEventTypeList
        .where((element) => element.eventTypeId == eventType.eventTypeId)
        .toList();
    if (eventType.selected && list.length == 0) {
      _selectedEventTypeList.add(eventType);
      print('added');
    } else {
      _selectedEventTypeList.remove(eventType);
      print('removed');
    }

    notifyListeners();
  }

  bool isEventTypeLoading = false;

  void loadEventType() async {
    isEventTypeLoading = true;
    List<EventType> eventTypeList =
        await onboardService.getEventTypes(user: auth.user);

    isEventTypeLoading = false;
    setEventTypeList(eventTypeList);
  }

  void setEventTypeList(List<EventType> eventTypeList) {
    _eventTypeList = eventTypeList;

    notifyListeners();
  }

  // updateUserSelectedList(List<BaseEventType> list) {
  //   for (BaseEventType baseEventType in list) {
  //     print('base Category adding: ${baseEventType.id}');
  //     _selectedEventTypeList.add(
  //       EventType(
  //         id: baseEventType.id,
  //         name: baseEventType.name,
  //         eventTypeId: baseEventType.eventTypeId,
  //       ),
  //     );
  //   }
  // }
}
