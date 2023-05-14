// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:predict_coffee/data/models/single_predict_models/single_predict_models.dart';
import 'package:predict_coffee/data/models/single_predict_models/single_predict_response.dart';

import '../../utils/exception.dart';
import '../models/multi_predict_models/multi_predict_models.dart';

abstract class ApiDataSource {
  Future<List<PredictionModel>> createSinglePredict(String filePath);
  Future<List<List<MultiPrediction>>> createMultiPredict(
    List<String> filePaths,
  );
}

class CoffeeDataSourceIMPL extends ApiDataSource {
  static const apiURL = 'http://10.0.2.2:5000';

  Dio dio = Dio();

  CoffeeDataSourceIMPL({required this.dio});

  @override
  Future<List<PredictionModel>> createSinglePredict(filePath) async {
    try {
      String fileName = filePath.split('/').last;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      Response response = await dio.post(
        "$apiURL/singleprediction",
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      if (response.statusCode == 200) {
        return SinglePredictModels.fromJson(response.data).predict;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      String error = e.response?.data['message'];
      throw ServerException(error);
    }
  }

  @override
  Future<List<List<MultiPrediction>>> createMultiPredict(filePaths) async {
    try {
      List<MultipartFile> files = [];

      for (String filePath in filePaths) {
        String fileName = filePath.split('/').last;
        files.add(await MultipartFile.fromFile(filePath, filename: fileName));
      }

      FormData formData = FormData.fromMap({'file': files});

      Response response = await dio.post(
        "$apiURL/multipredictions",
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((data) => MultiPredictions.fromJson(data).prediction)
            .toList();
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      String error = e.response?.data['message'];
      throw ServerException(error);
    }
  }
}
