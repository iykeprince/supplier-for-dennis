import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_work_time.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_work_time.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

import 'viewmodels/work_hour_model.dart';
import 'widgets/round_edit_button.dart';

class WorkHoursView extends StatelessWidget {
  WorkHoursView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkHourModel>(
      builder: (context, model, child) => Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 16.0,
                top: 8,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Work Hours',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  model.isEditMode
                      ? Row(
                          children: [
                            RaisedButton(
                              color: CustomColor.primaryColor,
                              onPressed: model.loading
                                  ? null
                                  : () async {
                                      model.setLoading(true);
                                      List<BaseWorkTime> baseWorkTimes =
                                          await model.updateWorkTime();

                                      model.setWorkTime(baseWorkTimes);
                                      model.setLoading(false);
                                      if (baseWorkTimes != null &&
                                          baseWorkTimes.length > 0) {
                                        print('Success: $baseWorkTimes');
                                      } else {
                                        print('Something went wrong');
                                      }
                                      model.toggleMode();
                                    },
                              child: Container(
                                child: Row(
                                  children: [
                                    model.loading
                                        ? Center(
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Update',
                                            style: GoogleFonts.workSans(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: model.toggleMode,
                              child: Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Back',
                                  style: GoogleFonts.workSans(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : RoundEditButton(
                          onTap: model.toggleMode,
                        ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 8.0,
                top: 8,
                bottom: 4,
              ),
              child: Column(
                children: model.workdays
                    .map(
                      (workday) => WorkDay(
                        workday: workday,
                        isEditMode: model.isEditMode,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkDay extends StatefulWidget {
  final bool isEditMode;
  final WorkTimeElement workday;

  WorkDay({
    Key key,
    this.isEditMode,
    this.workday,
  }) : super(key: key);

  @override
  _WorkDayState createState() => _WorkDayState();
}

class _WorkDayState extends State<WorkDay> {
  bool _switchState = false;

  List<String> times = [];

  @override
  Widget build(BuildContext context) {
    WorkHourModel workHourModel = Provider.of<WorkHourModel>(context);

    BaseWorkTime _baseWorkTime = workHourModel.workTimes != null &&
            workHourModel.workTimes.length > 0
        ? workHourModel.workTimes.firstWhere(
            (element) => element.id.contains(widget.workday.id.toLowerCase()),
            orElse: () => null)
        : null;
    if (_baseWorkTime != null && !widget.isEditMode) _switchState = true;

    times = generateTimes();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade200),
            ),
            child: Text(
              '${HelperUtil.capitalize(widget.workday.id)}',
              style: GoogleFonts.workSans(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 65,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade200),
            ),
            child: Switch.adaptive(
              activeColor: CustomColor.primaryColor,
              value: _switchState,
              onChanged: !widget.isEditMode
                  ? null
                  : (bool switchState) {
                      if (switchState) {
                        workHourModel.addWorkday(widget.workday);
                      } else {
                        workHourModel.removeWorkday(widget.workday);
                      }
                      setState(() {
                        _switchState = switchState;
                      });
                    },
            ),
          ),
          WorkTimeView(
            workday: widget.workday,
            times: times,
            supplierWorkTime: _baseWorkTime, //work time from the server
            switchState: _switchState,
            isEditMode: widget.isEditMode,
          )
        ],
      ),
    );
  }

  List<String> generateTimes() {
    final times = HelperUtil.getTimes();
    return times;
  }
}

class WorkTimeView extends StatefulWidget {
  final bool switchState;

  final String open;
  final String close;
  final List<String> times;
  final WorkTimeElement workday;
  final bool isEditMode;
  final BaseWorkTime supplierWorkTime;

  WorkTimeView({
    Key key,
    this.switchState,
    this.open,
    this.close,
    this.times,
    this.workday,
    this.isEditMode,
    this.supplierWorkTime,
  }) : super(key: key);

  @override
  _WorkTimeViewState createState() => _WorkTimeViewState();
}

class _WorkTimeViewState extends State<WorkTimeView> {
  String _selectedOpen;
  String _selectedClose;

  List<String> filteredTimes = [];
  @override
  void initState() {
    filteredTimes = widget.times;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WorkHourModel workHourModel = Provider.of<WorkHourModel>(context);
    if (widget.supplierWorkTime != null) {
      _selectedOpen =
          '${HelperUtil.leadingZero(widget.supplierWorkTime.times.open.hour)}:${HelperUtil.leadingZero(widget.supplierWorkTime.times.open.minute)}';
      _selectedClose =
          '${HelperUtil.leadingZero(widget.supplierWorkTime.times.close.hour)}:${HelperUtil.leadingZero(widget.supplierWorkTime.times.close.minute)}';
    }
    return Expanded(
      child: Row(children: [
        !widget.switchState
            ? Container(
                width: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                ),
                child: Text(
                  'Closed',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    color: Colors.grey.shade300,
                  ),
                ),
              )
            : !widget.isEditMode
                ? Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '${HelperUtil.leadingZero(widget.supplierWorkTime.times.open.hour)}:${HelperUtil.leadingZero(widget.supplierWorkTime.times.open.minute)}',
                        style: GoogleFonts.workSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '${HelperUtil.leadingZero(widget.supplierWorkTime.times.close.hour)}:${HelperUtil.leadingZero(widget.supplierWorkTime.times.close.minute)}',
                        style: GoogleFonts.workSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ])
                : Row(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: false,
                            elevation: 1,
                            items: widget.times.length > 0
                                ? _buildDropdown(widget.times)
                                : [],
                            onChanged: (value) {
                              print('value: $value');
                              print('widget.workday.id): ${widget.workday.id}');

                              int index = workHourModel.selectedWorkdays
                                  .indexOf(widget.workday);
                              print('selected workday index: $index');
                              workHourModel.setOpen(index, value);
                              int timeIndex = widget.times.indexOf(value) + 1;
                              print('TIME INDEX: $timeIndex');
                              setState(() {
                                _selectedOpen = value;
                                filteredTimes = widget.times.sublist(timeIndex);
                                print('filtered times: $filteredTimes');
                              });
                            },
                            value: _selectedOpen,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: false,
                            elevation: 1,
                            items: filteredTimes.length > 0
                                ? _buildDropdown(filteredTimes)
                                : [],
                            onChanged: (value) {
                              print('value close: $value');
                              int index = workHourModel.selectedWorkdays
                                  .indexOf(widget.workday);
                              workHourModel.setClose(index, value);
                              setState(() {
                                _selectedClose = value;
                              });
                            },
                            value: _selectedClose,
                          ),
                        ),
                      )
                    ],
                  ),
      ]),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdown(List<String> times) {
    List<DropdownMenuItem<String>> list = [];
    times.forEach((time) {
      var item = DropdownMenuItem<String>(
        child: Center(
          child: Text(
            '$time',
            style: GoogleFonts.workSans(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        value: time,
      );
      list.add(item);
    });
    return list;
  }
}
