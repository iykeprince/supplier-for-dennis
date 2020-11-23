import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:uplanit_supplier/core/models/business_profile/address.dart';
import 'package:uplanit_supplier/core/models/business_profile/address_response.dart';
import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/business_profile/country.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/business_profile/address_information.dart';
import 'package:uuid/uuid.dart';

class AddressModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();
  // LatLng _center = const LatLng(51.568747, 0.420410);
  bool _showMarker = false;
  bool _loading = false;
  bool _isCountryLoading = false;
  Address _address;
  BaseAddress _baseAddress; //address returned from the server
  BaseDeliveryBounds _baseDeliveryBounds; //deliveryBounds from the server
  List<Country> _countries = [];
  Country _country;
  String _errorMessage = '';

  bool get showMarker => _showMarker;
  bool get isCountryLoading => _isCountryLoading;
  bool get loading => _loading;
  Address get address => _address;
  BaseAddress get baseAddress => _baseAddress;
  BaseDeliveryBounds get baseDeliveryBounds => _baseDeliveryBounds;
  List<Country> get countries => _countries;
  Country get country => _country;
  String get errorMessage => _errorMessage;

  final TextEditingController numberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  Completer<GoogleMapController> controller = Completer();
  GoogleMapController googleMapController;

  CameraUpdate _cameraUpdate;
  CameraUpdate get cameraUpdate => _cameraUpdate;

  init() async {
    googleMapController = await controller.future;

    fetchCountries();
    if (baseAddress != null) {
      LatLng center = LatLng(
        baseAddress.location.y,
        baseAddress.location.x,
      );
      setCameraUpdate(center);
      
      bool shouldShowMarker =
          baseAddress.showMarker.toLowerCase() == 'true' ? true : false;
      print('value of show marker: $shouldShowMarker');
      setShowMarker(shouldShowMarker);
      if (showMarker) {
        setMarker(center);
      } else {
        setCircles(center);
      }
    }

    if (baseDeliveryBounds != null) {
      //Bounds
      print('bounds');
      print('${baseDeliveryBounds.north}');
      print('${baseDeliveryBounds.south}');
      print('${baseDeliveryBounds.east}');
      print('${baseDeliveryBounds.west}');

      polygonLatLngs.clear();
      polygonLatLngs
          .add(LatLng(baseDeliveryBounds.north, baseDeliveryBounds.west));
      polygonLatLngs.add(
        LatLng(baseDeliveryBounds.north, baseDeliveryBounds.east),
      );
      polygonLatLngs.add(
        LatLng(baseDeliveryBounds.south, baseDeliveryBounds.east),
      );
      polygonLatLngs
          .add(LatLng(baseDeliveryBounds.south, baseDeliveryBounds.west));
      setPolygon(polygonLatLngs);
      // --Bounds
    }
  }

  updateFields(model) {
    if (baseAddress != null) {
      numberController.text = baseAddress.number;
      streetController.text = baseAddress.street;
      postCodeController.text = baseAddress.postCode;
      cityController.text = baseAddress.city;
    }
  }

  //map object
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  List<LatLng> _polygonLatLngs = List<LatLng>();

  Set<Marker> get markers => _markers;
  Set<Circle> get circles => _circles;
  Set<Polygon> get polygons => _polygons;
  List<LatLng> get polygonLatLngs => _polygonLatLngs;

  int _polygonIdCounter = 1;
  int _circleIdCounter = 1;
  int _markerIdCounter = 1;

  setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void setMarker(LatLng point) {
    _markers.clear();
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    print('Marker: lat: ${point.latitude} lng: ${point.longitude}');
    _markers.add(
      Marker(
        markerId: MarkerId(markerIdVal),
        position: point,
      ),
    );
    notifyListeners();
  }

  void setCircles(LatLng point) {
    _circles.clear();
    final String circleIdVal = 'marker_id_$_circleIdCounter';
    _circleIdCounter++;
    print('Circle: lat: ${point.latitude} lng: ${point.longitude}');
    _circles.add(
      Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: 500,
        fillColor: Colors.redAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent,
      ),
    );
    notifyListeners();
  }

  //Draw a _polygon
  void setPolygon(List<LatLng> polygonLatLngs) {
    _polygons.clear();
    print('polygon: $polygonLatLngs');
    String polygonIdVal = Uuid().v4();
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        strokeColor: CustomColor.uplanitBlue.withOpacity(0.1),
        fillColor: CustomColor.uplanitBlue.withOpacity(0.4),
      ),
    );
    notifyListeners();
  }

  void setCameraUpdate(LatLng latLng) async {
    print('=========SET CAMERA UPDATE=========');
    print('camera update lat: ${latLng.latitude}/lng: ${latLng.longitude}');
    _cameraUpdate = CameraUpdate.newLatLng(latLng);
    try {
      await googleMapController.moveCamera(_cameraUpdate);
    } catch (e) {
      print('camera update exception: ${e.toString()}');
    }
    notifyListeners();
  }

  setFields(geo.Placemark placemark) {
    print('placemark: $placemark');
    numberController.text = placemark.name;
    postCodeController.text = placemark.postalCode;
    cityController.text = placemark.locality.isEmpty
        ? placemark.administrativeArea
        : placemark.locality;
    streetController.text = placemark.street;
    print(
        'number: ${numberController.text} postcode: ${postCodeController.text}');
    notifyListeners();
  }

  ALocation _aLocation;

  ALocation get aLocation => _aLocation;

  double _lat;
  double _lng;
  double get lat => _lat;
  double get lng => _lng;

  // GoogleMapController _googleController;
  // GoogleMapController get googleController => _googleController;

  // void setGoogleMapController(GoogleMapController controller) {
  //   _googleController = controller;
  //   print('google map controller called');
  //   notifyListeners();
  // }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setLatLng(double lat, double lng) {
    _lat = lat;
    _lng = lng;
    _aLocation = ALocation(x: lng, y: lat);
    notifyListeners();
  }

  void setCountryValue(Country country) {
    _country = country;
    notifyListeners();
  }

  void setShowMarker(bool showMarker) {
    _showMarker = showMarker;
    notifyListeners();
  }

  void setAddress(BaseAddress address) {
    _baseAddress = address;
    init();
    notifyListeners();
  }

  void setDeliveryBounds(BaseDeliveryBounds deliveryBounds) {
    _baseDeliveryBounds = deliveryBounds;
    notifyListeners();
  }

  void fetchCountries() async {
    _countries.clear();
    _isCountryLoading = true;
    List<Country> countries = await _businessProfileService.getCountries();
    _countries = countries;
    _isCountryLoading = false;
    print('loading countries');
    notifyListeners();
  }

  Future<AddressResponse> updateAddress() async {
    String number = numberController.text.trim();
    String street = streetController.text.trim();
    String postCode = postCodeController.text.trim();
    String city = cityController.text.trim();

    if (country == null) {
      setErrorMessage('Please select country');
      return null;
    }
    setErrorMessage("");
    String token = await auth.user.getIdToken();
    Address newAddress = Address(
      number: number,
      street: street,
      postCode: postCode,
      city: city,
      country: country.id,
      showMarker: showMarker.toString(),
      location: ALocation(
        x: aLocation.x,
        y: aLocation.y,
      ),
      deliveryBounds: DeliveryBounds(
        north: aLocation.y + 0.09,
        south: aLocation.y - 0.09,
        east: aLocation.x + 0.09,
        west: aLocation.x - 0.09,
      ),
    );

    if (baseAddress == null) {
      return await _businessProfileService.createAddress(
        token: token,
        address: newAddress,
      );
    } else {
      return await _businessProfileService.updateAddress(
        token: token,
        address: newAddress,
      );
    }
  }
}
