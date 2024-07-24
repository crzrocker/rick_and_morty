class Character {
  int? id;
  String name = '';
  String species = '';
  String type = '';
  String gender = '';
  String? image;
  String createdDate = '';
  String location = '';
  String status = '';

  Character(this.id, this.name, this.species, this.type, this.gender,
      this.image, this.createdDate, this.status, this.location);

  Character.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'] == null || json['name'] == ''
        ? 'Name Unknown'
        : json['name'];
    species = json['species'] == null || json['species'] == ''
        ? 'Species Unknown'
        : json['species'];
    type = json['type'] == null || json['type'] == ''
        ? 'Type Unknown'
        : json['type'];
    gender = json['gender'] == null || json['gender'] == ''
        ? 'Gender Unknown'
        : json['gender'];
    image = json['image'];
    createdDate = json['createdDate'] == null || json['createdDate'] == ''
        ? 'Date Unknown'
        : json['createdDate'];
    status = json['status'] == null || json['status'] == ''
        ? 'Status Unknown'
        : json['status'];
    location = json['location'] == null ||
            json['location']['name'] == null ||
            json['location']['name'] == ''
        ? 'Location Unknown'
        : json['location']['name'];
  }

  @override
  String toString() {
    return 'id: $id; name: $name; species: $species; type: $type; gender: $gender; image: $image; date:$createdDate ';
  }
}
