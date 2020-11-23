import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/enums/event_type.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/event_type.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/event_type_provider.dart';
import 'package:uplanit_supplier/ui/views/onboard/all_done.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class EventTypeDialog extends StatelessWidget {
  final BusinessProfileModel _businessProfileModel =
      locator<BusinessProfileModel>();
  final EventTypeEnum eventTypeEnum;
  EventTypeDialog({
    Key key,
    this.eventTypeEnum = EventTypeEnum.CREATE_EVENT_TYPE,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 540,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    eventTypeEnum == EventTypeEnum.CREATE_EVENT_TYPE
                        ? Text(
                            'One last step',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                    Container(
                      width: 200,
                      child: Text(
                        eventTypeEnum == EventTypeEnum.CREATE_EVENT_TYPE
                            ? 'What events will you be supplying for?'
                            : 'Select the events you will like to update!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: EventTypeView(
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  Consumer<EventTypeProvider>(
                    builder: (context, value, child) => FlatButton(
                      child: value.state == ViewState.Busy
                          ? CustomProgressWidget()
                          : Text('FINISH'),
                      onPressed: value.selectedEventTypeList.length == 0
                          ? null
                          : () async {
                              value.setState(ViewState.Busy);
                              List<EventType> eventTypes;
                              if (eventTypeEnum ==
                                  EventTypeEnum.CREATE_EVENT_TYPE) {
                                eventTypes = await value.createEventType();
                                value.setState(ViewState.Idle);
                                if (eventTypes.length > 0) {
                                  Navigator.pushNamed(context, AllDone.ROUTE);
                                } else {
                                  print('An error has occurred');
                                }
                              } else if (eventTypeEnum ==
                                  EventTypeEnum.UPDATE_EVENT_TYPE) {
                                eventTypes = await value.updateEventType();

                                if (eventTypes.length > 0) {
                                  List<BaseEventType> baseEventTypes = [];
                                  for (int i = 0; i < eventTypes.length; i++) {
                                    baseEventTypes.add(
                                      BaseEventType(
                                        name: eventTypes[i].name,
                                        id: eventTypes[i].id,
                                        eventTypeId: eventTypes[i].eventTypeId,
                                      ),
                                    );
                                  }
                                  _businessProfileModel.updateBaseEventTypes(
                                    baseEventTypes,
                                    listen: true,
                                  );
                                  Navigator.of(context).pop(false);
                                } else {
                                  print('An error has occurred');
                                }
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTypeView extends StatefulWidget {
  EventTypeView({Key key}) : super(key: key);

  @override
  _EventTypeViewState createState() => _EventTypeViewState();
}

class _EventTypeViewState extends State<EventTypeView> {
  EventTypeProvider _eventTypeProvider;
  @override
  void initState() {
    context.read<EventTypeProvider>().loadEventType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _eventTypeProvider = Provider.of(context);
    List<EventType> _list = _eventTypeProvider.eventTypeList;
    bool isEventTypeLoading = _eventTypeProvider.isEventTypeLoading;

    return isEventTypeLoading
        ? CustomProgressWidget()
        : GridView.builder(
            shrinkWrap: true,
            itemCount: _list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) => _buildItem(
                  context,
                  index,
                  _list,
                ));
  }

  _buildItem(BuildContext context, int index, List<EventType> eventTypes) {
    EventType eventType = eventTypes[index];

   
    return InkWell(
      onTap: () {
        context.read<EventTypeProvider>().addSelected(index);
      },
      child: Opacity(
        opacity: eventType.selected ? 1 : .4,
        child: Container(
          width: 106,
          height: 108,
          decoration: BoxDecoration(
            color: CustomColor.uplanitBlue,
          ),
          child: Center(
            child: Text(
              eventType.name,
              style: GoogleFonts.workSans(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
