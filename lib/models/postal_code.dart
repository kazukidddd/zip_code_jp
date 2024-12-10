class PostalCode {
  final String id;
  final String jisCode;
  final String oldZipCode;
  final String zipCode;
  final String prefectureKana;
  final String cityKana;
  final String townKana;
  final String prefecture;
  final String city;
  final String town;
  final bool hasMultipleZipCodes;
  final bool hasNumberedEveryKoaza;
  final bool hasChome;
  final bool hasMultipleAreas;
  final String updateStatus;
  final String updateReason;
  final DateTime updatedAt;

  PostalCode({
    required this.id,
    required this.jisCode,
    required this.oldZipCode,
    required this.zipCode,
    required this.prefectureKana,
    required this.cityKana,
    required this.townKana,
    required this.prefecture,
    required this.city,
    required this.town,
    required this.hasMultipleZipCodes,
    required this.hasNumberedEveryKoaza,
    required this.hasChome,
    required this.hasMultipleAreas,
    required this.updateStatus,
    required this.updateReason,
    required this.updatedAt,
  });

  factory PostalCode.fromCsv(List<String> row) {
    return PostalCode(
      id: '${row[2]}_${row[7]}_${row[8]}',
      jisCode: row[0],
      oldZipCode: row[1],
      zipCode: row[2],
      prefectureKana: row[3],
      cityKana: row[4],
      townKana: row[5],
      prefecture: row[6],
      city: row[7],
      town: row[8],
      hasMultipleZipCodes: row[9] == '1',
      hasNumberedEveryKoaza: row[10] == '1',
      hasChome: row[11] == '1',
      hasMultipleAreas: row[12] == '1',
      updateStatus: row[13],
      updateReason: row[14],
      updatedAt: DateTime.now(),
    );
  }
}
