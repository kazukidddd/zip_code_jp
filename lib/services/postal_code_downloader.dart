import 'dart:io';

import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PostalCodeDownloader {
  static const String postalCodeUrl =
      'https://www.post.japanpost.jp/zipcode/dl/utf/zip/utf_ken_all.zip';

  /// ZIPファイルをダウンロードして解凍し、CSVデータを取得
  Future<File> downloadAndExtractCsv() async {
    // ダウンロード
    final response = await http.get(Uri.parse(postalCodeUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to download ZIP file');
    }

    // 一時ディレクトリにZIPファイルを保存
    final tempDir = await getTemporaryDirectory();
    final zipFilePath = '${tempDir.path}/postal_codes.zip';
    final zipFile = File(zipFilePath);
    await zipFile.writeAsBytes(response.bodyBytes);

    // 解凍
    final archive = ZipDecoder().decodeBytes(response.bodyBytes);
    File? csvFile;
    for (final file in archive) {
      if (file.isFile && file.name.endsWith('.csv')) {
        final csvPath = '${tempDir.path}/${file.name}';
        csvFile = File(csvPath)..writeAsBytesSync(file.content as List<int>);
        break;
      }
    }

    if (csvFile == null) {
      throw Exception('CSV file not found in ZIP');
    }

    return csvFile;
  }
}
