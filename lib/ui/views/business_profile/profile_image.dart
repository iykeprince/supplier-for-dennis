import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';

import 'package:uplanit_supplier/core/models/business_profile/base_profile.dart';
import 'package:uplanit_supplier/core/models/business_profile/cover_image.dart';
import 'package:uplanit_supplier/core/utils/filehandler_util.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/ui/views/business_profile/widgets/cache_cover_widget.dart';
import 'package:uplanit_supplier/ui/views/business_profile/widgets/cache_logo_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uuid/uuid.dart';

import 'viewmodels/profile_image_model.dart';

class ProfileImageView extends StatelessWidget {
  ProfileImageView({Key key}) : super(key: key);
  File _selectedCoverFile, _selectedLogoFile;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileImageModel>(
          builder: (context, model, child) => Padding(
            padding: const EdgeInsets.only(top: 4.0, right: 16.0, left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      model.cover != null
                          ? CacheCoverWidget(
                              imageUrl: '${model.cover.path}',
                            )
                          : InkWell(
                              onTap: () => uploadCoverImage(model),
                              child: InkWell(
                                onTap: () => uploadCoverImage(model),
                                child: _buildEmptyCoverImage(model),
                              ),
                            ),
                      model.cover != null
                          ? Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () => uploadCoverImage(model),
                                  child: model.isCoverUploading
                                      ? CustomProgressWidget()
                                      : Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.mode_edit,
                                            color: Colors.grey,
                                          ),
                                        ),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: -25,
                        left: 159,
                        child: InkWell(
                          onTap: () => uploadLogo(model),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              model.logo != null
                                  ? CacheLogoWidget(
                                      imageUrl: '${model.logo.path1M}',
                                    )
                                  : InkWell(
                                      onTap: () => uploadLogo(model),
                                      child: _buildEmptyLogoImage(model),
                                    ),
                              model.logo != null
                                  ? Positioned(
                                      right: -8,
                                      bottom: -8,
                                      child: model.isLogoUploading
                                          ? CustomProgressWidget()
                                          : Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                              child: Icon(
                                                Icons.mode_edit,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 36,
                  ),
                  child: Text(
                    '${model.auth.user.displayName}',
                    style: GoogleFonts.workSans(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildEmptyLogoImage(ProfileImageModel model) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              15.0, // Move to right 10  horizontally
              15.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child:  model.isLogoUploading
              ? CustomProgressWidget()
              : Text(
                  'Upload Logo Image',
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildEmptyCoverImage(ProfileImageModel model) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          alignment: Alignment.center,
          height: 156,
          child: Stack(
            children: [
              Center(
                child: Text(
                  '*Upload Cover Image',
                  style: GoogleFonts.workSans(
                    fontSize: 28,
                    color: Colors.grey,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child:   model.isCoverUploading
                    ? CustomProgressWidget()
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadCoverImage(ProfileImageModel model) async {
    model.setIsCoverUploading(true);
    _selectedCoverFile = await FileHandlerUtil.handlePickImage();
    if (_selectedCoverFile == null) {
      model.setIsCoverUploading(false);
      return;
    }
    String filePath = _selectedCoverFile.path;
    // model.setCover(filePath);
    String generatedUuid = Uuid().v4();
    String fileExtension = FileHandlerUtil.getExtension(filePath);

    String filename = '$generatedUuid$fileExtension';
    print('filename: $filename');
    //1. get the file upload url
    String fileUploadURL = await model.getFileUploadURL(
      filename: filename,
      type: mime(filePath),
    );
    print('file upload URL: $fileUploadURL');

    // //2. upload file to s3
    String responseFromS3 = await model.uploadFileToS3(
      url: fileUploadURL,
      file: _selectedCoverFile,
    );
    print('response from s3: $responseFromS3');
    //3. Update cover image
    CoverImage cover = await model.updateCoverImage(coverImage: filename);
    model.setCoverImage(cover);
    print('uploaded with cover: ${cover.name}');
    model.setIsCoverUploading(false);
  }

  uploadLogo(ProfileImageModel model) async {
    print('clicking');
    model.setIsLogoUploading(true);
    _selectedLogoFile = await FileHandlerUtil.handlePickImage();
    if (_selectedLogoFile == null) {
      model.setIsLogoUploading(false);
      //operation was cancelled by user
      return;
    }

    String filePath = _selectedLogoFile.path;
    // model.setLogo(filePath);
    String generatedUuid = Uuid().v4();
    String fileExtension = FileHandlerUtil.getExtension(filePath);

    String filename = '$generatedUuid$fileExtension';
    print('filename: $filename');
    //1. get the file upload url
    String fileUploadURL = await model.getFileUploadURL(
      filename: filename,
      type: mime(filePath),
    );
    print('file upload URL: $fileUploadURL');

    // //2. upload file to s3
    String responseFromS3 = await model.uploadFileToS3(
      url: fileUploadURL,
      file: _selectedLogoFile,
    );
    print('response from s3: $responseFromS3');
    //3. Update cover image
    CoverImage logo = await model.updateLogoImage(logoImage: filename);
    print('uploaded with cover: ${logo.path}');
    
    model.setLogoImage(logo);
    model.setIsLogoUploading(false);
  }
}
