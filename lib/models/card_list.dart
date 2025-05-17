class CardList {
  final String name;
  final String ipaddress;

  CardList(
    this.name,
    this.ipaddress,
  );
  Map<String, String> toJson() => {
        'name': name,
        'ipaddress': ipaddress,
      };

  factory CardList.fromJson(Map<String, dynamic> json) {
    return CardList(
      json['name'] ?? '',
      json['ipaddress'] ?? '',
    );
  }
}
