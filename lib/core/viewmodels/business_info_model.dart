import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class BusinessInfoModel extends BaseModel {
  List<String> businessTypes = [
    '--Select--',
    'A sole trader',
    'A registered Company'
  ];

  String _selectedBusinessType = '--Select--';
  bool _isSoleTraderSelected;

  // String _companyName;
  // String _companyNumber;
  // String _businessRepresentative;
  // String _contactNumber;
  // String _vat;

  // String get companyName => _companyName;
  // String get companyNumber => _companyNumber;
  // String get businessRepresent

  BehaviorSubject<String> _companyNameController = BehaviorSubject<String>();
  BehaviorSubject<String> _companyNumberController = BehaviorSubject<String>();
  BehaviorSubject<String> _businessRepresentativeController =
      BehaviorSubject<String>();
  BehaviorSubject<String> _contactNumberController = BehaviorSubject<String>();
  BehaviorSubject<String> _vatController = BehaviorSubject<String>();

  Stream<String> get companyNameStream => _companyNameController.stream
          .transform(StreamTransformer<String, String>.fromHandlers(
              handleData: (data, sink) {
        if (data.isNotEmpty) {
          sink.add(data);
          setCompanyName(data);
        } else {
          sink.addError('Field is required');
        }
      }));
  Stream<String> get companyNumberStream => _companyNumberController.stream
          .transform(StreamTransformer<String, String>.fromHandlers(
              handleData: (data, sink) {
        if (data.isNotEmpty) {
          sink.add(data);
          setCompanyNumber(data);
        } else {
          sink.addError('Field is required');
        }
      }));
  Stream<String> get businessRepresentativeStream =>
      _businessRepresentativeController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (data, sink) {
        if (data.isNotEmpty) {
          sink.add(data);
          setBusinessRepresentative(data);
        } else {
          sink.addError('Field is required');
        }
      }));
  Stream<String> get contactNumberStream => _contactNumberController.stream
          .transform(StreamTransformer<String, String>.fromHandlers(
              handleData: (data, sink) {
        if (data.isNotEmpty) {
          sink.add(data);
          setContactNumber(data);
        } else {
          sink.addError('Field is required');
        }
      }));
  Stream<String> get vatStream => _vatController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (data, sink) {
        if (data.isNotEmpty) {
          sink.add(data);
          setVat(data);
        } else {
          sink.addError('Field is required');
        }
      }));

  Function(String) get changeCompanyName => _companyNameController.sink.add;
  Function(String) get changeCompanyNumber => _companyNumberController.sink.add;
  Function(String) get changeBusinessRepresentative =>
      _businessRepresentativeController.sink.add;
  Function(String) get changeContactNumber => _contactNumberController.sink.add;
  Function(String) get changeVat => _vatController.sink.add;

  Stream<bool> get isSoleTraderSubmitValid => Rx.combineLatest2(
      businessRepresentativeStream, contactNumberStream, (a, b) => true);
  Stream<bool> get isRegisteredCompanySubmitValid => Rx.combineLatest5(
      companyNameStream,
      companyNumberStream,
      _businessRepresentativeController,
      contactNumberStream,
      vatStream,
      (a, b, c, d, e) => true);

  dispose() {
    _companyNameController.close();
    _companyNumberController.close();
    _businessRepresentativeController.close();
    _contactNumberController.close();
    _vatController.close();
  }

  String get selectedBusinessType => _selectedBusinessType;
  bool get isSoleTraderSelected => _isSoleTraderSelected;

  void setSelectedBusinessType(String businessType) {
    _selectedBusinessType = businessType;
    if (_selectedBusinessType == '--Select--') {
      _isSoleTraderSelected = null;
    } else if (_selectedBusinessType == 'A sole trader') {
      _isSoleTraderSelected = true;
    } else {
      _isSoleTraderSelected = false;
    }
    notifyListeners();
  }

  String _companyName;
  String _companyNumber;
  String _businessRepresentative;
  String _contactNumber;
  String _vat;

  String get companyName => _companyName;
  String get companyNumber => _companyNumber;
  String get businessRepresentative => _businessRepresentative;
  String get contactNumber => _contactNumber;
  String get vat => _vat;

  void setCompanyName(String value) {
    _companyName = value;
    notifyListeners();
  }

  void setCompanyNumber(String value) {
    _companyNumber = value;
    notifyListeners();
  }

  void setBusinessRepresentative(String value) {
    _businessRepresentative = value;
    notifyListeners();
  }

  void setContactNumber(String value) {
    _contactNumber = value;
    notifyListeners();
  }

  void setVat(String value) {
    _vat = value;
    notifyListeners();
  }
  // void setIsSoleTraderSelected(bool selected) {
  //   _isSoleTraderSelected = selected;
  //   notifyListeners();
  // }

  void validateForm() {
    notifyListeners();
  }
}
