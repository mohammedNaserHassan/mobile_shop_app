class Addres {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  num? latitude;
  num? longitude;

  Addres(
      {this.id,
        this.name,
        this.city,
        this.region,
        this.details,
        this.notes,
        this.latitude,
        this.longitude});

  Addres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['region'] = this.region;
    data['details'] = this.details;
    data['notes'] = this.notes;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}