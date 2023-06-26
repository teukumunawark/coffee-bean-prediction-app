import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../utils/constants.dart';
import '../models/coffee_beans_list_models.dart';
import '../models/coffee_beans_models.dart';

abstract class RemoteDataSource {
  Future<List<CoffeeBeansModel>> makeMultiClassification(
    List<String> imagePathList,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CoffeeBeansModel>> makeMultiClassification(
    List<String> imagePathList,
  ) async {
    final List<MultipartFile> images = await Future.wait(
      imagePathList.map((path) => MultipartFile.fromFile(path)),
    );

    final FormData formData = FormData.fromMap({'image': images});

    final Response response = await dio.post(
      "$apiURL/multiclassifications",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );

    if (response.statusCode == 200) {
      return CoffeeBeansListModels.fromJson(response.data).result;
    } else {
      throw ServerException();
    }
  }
}
