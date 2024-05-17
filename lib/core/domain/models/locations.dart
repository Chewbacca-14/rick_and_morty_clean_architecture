class Location {
  final String? name;
  final String? type;
  final String? dimension;
  final String? url;

  Location({this.name, this.dimension, this.type, this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      type: json['type'],
      dimension: json['dimension'],
      url: json['url'],
    );
  }
}
