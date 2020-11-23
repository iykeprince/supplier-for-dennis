import 'dart:io';

import 'package:uplanit_supplier/core/models/portfolio/base_portfolio.dart';
import 'package:uplanit_supplier/core/models/portfolio/portfolio.dart';
import 'package:uplanit_supplier/core/models/portfolio/portfolio_response.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/portfolio_service.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

import 'base_model.dart';

class PortfolioModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  PortfolioService portfolioService = locator<PortfolioService>();

  Portfolio _portfolio;
  Map<String, List<int>> _imageHeights = {};
  bool _loading = false;
  bool _isProcessing = false;
  bool _deletingImage = false;
  bool _portfolioLoading = false;
  List<BasePortfolio> _basePortfolios = [];

  Map<String, List<int>> get imageHeights => _imageHeights;
  bool get loading => _loading;
  bool get isProcessing => _isProcessing;
  Portfolio get portfolio => _portfolio;
  bool get deletingImage => _deletingImage;
  List<BasePortfolio> get basePortfolios => _basePortfolios;
  bool get portfolioLoading => _portfolioLoading;

  PortfolioModel() {
    getPortfolios();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setPortfolioLoading(bool loading) {
    _portfolioLoading = loading;
    notifyListeners();
  }

  void setIsProcessing(bool isProcessing) {
    _isProcessing = isProcessing;
    notifyListeners();
  }

  getPortfolios() async {
    _portfolioLoading = true;
    List<BasePortfolio> portfolios = await getImages();

    _basePortfolios = portfolios;

    print('portfolio images: ${portfolios.length}');
    _portfolioLoading = false;
    notifyListeners();
  }

  void setDeletingImage(bool deleteImage) {
    _deletingImage = deleteImage;
    notifyListeners();
  }

  void setImageHeights(Map<String, List<int>> imageHeights) {
    _imageHeights = imageHeights;
    notifyListeners();
  }

  void setPortfolio(Portfolio portfolio) {
    _portfolio = portfolio;
    notifyListeners();
  }

  void addPortfolios(List<BasePortfolio> basePortfolios) {
    _basePortfolios = basePortfolios;
    print('from model: ${_basePortfolios.length}');
    notifyListeners();
  }

  void add(PortfolioResponse portfolio) {
    BasePortfolio basePortfolio = BasePortfolio(
      path: portfolio.path,
      path1M: portfolio.path1M,
      id: portfolio.id,
    );
    _basePortfolios.add(basePortfolio);
    notifyListeners();
  }

  Future<List<BasePortfolio>> getImages() async {
    String token = await auth.user.getIdToken();
    return await portfolioService.getImages(
      token: token,
    );
  }

  //get the file upload url
  Future<String> getFileUploadURL({String filename, String type}) async {
    String dynamicURL =
        ApiEndpoint.GET_FILE_UPLOAD_URL + "?name=$filename&type=$type";
    return await portfolioService.getFileUploadURL(
      user: auth.user,
      dynamicURL: dynamicURL,
    );
  }

  Future<String> uploadFileToS3({
    String url,
    File file,
  }) async {
    return await portfolioService.uploadFileToS3(
      url: url,
      file: file,
    );
  }

  Future<PortfolioResponse> addImage({String imageName, String uuid}) async {
    print('update portfolio');
    print('update image heights: $imageHeights');

    Portfolio portfolio = Portfolio(
      previewXxs: imageHeights["previewXxs"],
      previewXs: imageHeights["previewXs"],
      previewS: imageHeights["previewS"],
      previewM: imageHeights["previewM"],
      previewL: imageHeights["previewL"],
      previewXl: imageHeights["previewXl"],
      raw: imageHeights["raw"],
      name: imageName,
      uuid: uuid,
    );

    String token = await auth.user.getIdToken();
    return await portfolioService.addImage(
      token: token,
      portfolio: portfolio,
    );
  }

  Future<List<BasePortfolio>> deleteImage({String id}) async {
    String token = await auth.user.getIdToken();
    return await portfolioService.deleteImage(
      token: token,
      id: id,
    );
  }
}
