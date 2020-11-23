import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/models/portfolio/base_portfolio.dart';
import 'package:uplanit_supplier/core/models/portfolio/portfolio.dart';
import 'package:uplanit_supplier/core/models/portfolio/portfolio_response.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/utils/filehandler_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/portfolio_model.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uplanit_supplier/ui/views/business_info/business_info.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/core/viewmodels/drawer_model.dart';
import 'package:uuid/uuid.dart';
import 'package:overlay/overlay.dart';

import '../base_view.dart';
// import 'package:uplanit_supplier/ui/views/business_profile/profile_image.dart';

class PortfolioPage extends StatelessWidget {
  static const String ROUTE = '/portfolio/portfolio';

  List<String> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
  ];

  Map<String, List<int>> imageHeights = {
    "previewXxs": [0, 375],
    "previewXs": [0, 768],
    "previewS": [0, 1080],
    "previewM": [0, 1600],
    "previewL": [0, 2160],
    "previewXl": [0, 2880],
    "raw": [0, 1050]
  };

  Map<String, List<int>> map = {};

  DrawerModel _drawerModel;
  PortfolioModel _portfolioModel;
/**InkWell(
            onTap: m.loading
                ? null
                : () async {
                    _handleUploadPortfolio(m);
                    m.setLoading(false);
                  },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              height: 5.0,
              width: 122.0,
              decoration: BoxDecoration(
                color: Color(0XFFC20370),
              ),
              child: m.loading
                  ? CustomProgressWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.plus,
                          size: 16.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Add image ',
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
  **/
  @override
  Widget build(BuildContext context) {
    _portfolioModel = Provider.of<PortfolioModel>(context);
    _drawerModel = Provider.of<DrawerModel>(context);
    return BaseView<PortfolioModel>(
      onModelReady: (m) {
        _drawerModel.addActions(
          InkWell(
            onTap: m.loading
                ? null
                : () async {
                    _handleUploadPortfolio(m);
                    m.setLoading(false);
                  },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              height: 5.0,
              width: 122.0,
              decoration: BoxDecoration(
                color: Color(0XFFC20370),
              ),
              child: m.loading
                  ? CustomProgressWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.plus,
                          size: 16.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Add image ',
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
      builder: (context, model, child) => Consumer<PortfolioModel>(
        builder: (context, model, child) => Scaffold(
          // appBar: AppBar(actions: [
          //   InkWell(
          //   onTap: model.loading
          //       ? null
          //       : () async {
          //           _handleUploadPortfolio(model);
          //           model.setLoading(false);
          //         },
          //   child: Container(
          //     margin: const EdgeInsets.all(10.0),
          //     height: 5.0,
          //     width: 122.0,
          //     decoration: BoxDecoration(
          //       color: Color(0XFFC20370),
          //     ),
          //     child: model.loading
          //         ? CustomProgressWidget()
          //         : Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 FontAwesomeIcons.plus,
          //                 size: 16.0,
          //               ),
          //               SizedBox(width: 5.0),
          //               Text(
          //                 'Add image ',
          //                 style: GoogleFonts.workSans(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ],
          //           ),
          //   ),
          // ),
          // ],),
          body: model.portfolioLoading
              ? CustomProgressWidget()
              : model.basePortfolios.length == 0
                  ? Center(child: Text('No portfolio image'))
                  : GridView.builder(
                      itemCount: model.basePortfolios.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) =>
                          _gridItem(context, index, model.basePortfolios),
                    ),
        ),
      ),
    );
  }

  _gridItem(context, index, List<BasePortfolio> portfolios) {
    print('item: ${portfolios[index]}: images: ${portfolios.length}');
    String imageUrl = portfolios[index].path;

    return InkWell(
      onTap: () {
        _buildPortfolioOverlay(context, portfolios, index);
        // Navigator.pushNamed(
        //   context,
        //   BusinessInfoPage.ROUTE,
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: MediaQuery.of(context).size.width,
            height: 156,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPortfolioOverlay(
      BuildContext context, List<BasePortfolio> portfolios, int index) {
    String _id = portfolios[index].id;
    String path = portfolios[index].path;
    return CustomOverlay(
      context: context,
      // Using overlayWidget

      overlayWidget: Container(
        color: Color(0xAA000000),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(path),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    CircularProgressIndicator(),
                    RaisedButton(
                      onPressed: () async {
                        _portfolioModel.setDeletingImage(true);
                        List<BasePortfolio> basePortfolios =
                            await _portfolioModel.deleteImage(id: _id);
                        _portfolioModel.setDeletingImage(false);
                        if (basePortfolios != null &&
                            basePortfolios.length > 0) {
                          print('deleted');
                        }
                      },
                      child: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, List<int>>> _processImageEnhanced(
      File file, Map<String, List<int>> data) async {
    Map<String, List<int>> map = {};

    data.forEach((key, value) async {
      int height = value[1];
      try {
        List<int> list = [];
        list.clear();
        print('processing image for height: $height...');
        ui.Image image = await decodeImageFromList(file.readAsBytesSync());
        var pictureRecorder = ui.PictureRecorder();

        double scaleFactor = height / image.height;
        double width = image.width * scaleFactor;
        var canvas = Canvas(
          pictureRecorder,
        );
        canvas.drawImage(image, Offset.zero, Paint());

        var pic = pictureRecorder.endRecording();
        ui.Image img =
            await pic.toImage((image.width * scaleFactor).toInt(), height);
        // print('scaleFactor: $scaleFactor');
        // print('canvas image: [${img.width}, ${img.height}]');
        list.add(img.width);
        list.add(img.height);
        map[key] = list;
      } catch (e) {
        print('Render error: ${e.message}');
        return {};
      }
    });
    await Future.delayed(Duration(seconds: 2));
    return map;
  }

  _handleUploadPortfolio(PortfolioModel model) async {
    File selectedFile = await FileHandlerUtil.handlePickImage();
    if (selectedFile == null) return;
    model.setLoading(true);
    String filePath = selectedFile.path;
    //1. process the image
    // print('image height length: ${imageHeights.length}');
    Map<String, List<int>> map =
        await _processImageEnhanced(selectedFile, imageHeights);

    model.setImageHeights(map);
    //post to the process data to the server
    String fileExtension = FileHandlerUtil.getExtension(selectedFile.path);
    String uuid = Uuid().v4();
    String imageName = '${Uuid().v4()}$fileExtension';

    //get the aws generate url from Uplanit
    //1. get the file upload url
    String fileUploadURL = await model.getFileUploadURL(
      filename: imageName,
      type: mime(filePath),
    );
    print('portfolio file upload URL: $fileUploadURL');

    // // //2. upload file to s3
    String responseFromS3 = await model.uploadFileToS3(
      url: fileUploadURL,
      file: selectedFile,
    );
    print('portfolio response from s3: $responseFromS3');
    //3. post to uplanit again
    PortfolioResponse portfolioResponse = await model.addImage(
      uuid: uuid,
      imageName: imageName,
    );
    model.add(portfolioResponse);
    print('uploaded portfolio: ${portfolioResponse.name}');
    model.setLoading(false);
  }
}
