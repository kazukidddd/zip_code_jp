class PostalCode {
  final String jisCode;
  final String oldZipCode;
  final String zipCode;
  final String prefectureKana;
  final String cityKana;
  final String townKana;
  final String prefecture;
  final String city;
  final String town;

  PostalCode({
    required this.jisCode,
    required this.oldZipCode,
    required this.zipCode,
    required this.prefectureKana,
    required this.cityKana,
    required this.townKana,
    required this.prefecture,
    required this.city,
    required this.town,
  });

  factory PostalCode.fromCsv(List<String> row) {
    return PostalCode(
      jisCode: row[0],
      oldZipCode: row[1],
      zipCode: row[2],
      prefectureKana: row[3],
      cityKana: row[4],
      townKana: row[5],
      prefecture: row[6],
      city: row[7],
      town: row[8],
    );
  }
}
