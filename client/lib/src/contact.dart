class Contact {
  final String id;
  final String name;
  final String initials;

  const Contact._(
      {required this.id, required this.name, required this.initials});

  factory Contact.fromJson(Map json) {
    final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final names = json['name'].split(' ');
    final initials = names[0].substring(0, 1);
    return Contact._(id: id, name: json['name'], initials: initials);
  }
}
