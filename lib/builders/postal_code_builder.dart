import 'package:build/build.dart';
import 'package:csv/csv.dart';
import 'package:source_gen/source_gen.dart';

import '../models/postal_code.dart';
import '../services/postal_code_downloader.dart';

class PostalCodeBuilder extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    // CSVダウンロードと解凍
    final downloader = PostalCodeDownloader();
    final csvFile = await downloader.downloadAndExtractCsv();

    // CSVデータを読み取る
    final content = await csvFile.readAsString();
    final rows = const CsvToListConverter().convert(content);

    // PostalCodeインスタンスを作成しコード生成
    final buffer = StringBuffer();
    buffer.writeln('final postalCodeData = <PostalCode>[');

    for (var row in rows.skip(1)) {
      final postalCode = PostalCode.fromCsv(row.cast<String>());
      buffer.writeln('  PostalCode('
          'jisCode: "${postalCode.jisCode}", '
          'oldZipCode: "${postalCode.oldZipCode}", '
          'zipCode: "${postalCode.zipCode}", '
          'prefectureKana: "${postalCode.prefectureKana}", '
          'cityKana: "${postalCode.cityKana}", '
          'townKana: "${postalCode.townKana}", '
          'prefecture: "${postalCode.prefecture}", '
          'city: "${postalCode.city}", '
          'town: "${postalCode.town}"),');
    }

    buffer.writeln('];');
    return '';
  }
}
