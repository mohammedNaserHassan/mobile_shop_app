class Order {
  int? id;
  double? total;
  String? date;
  String? status;

  Order({this.id, this.total, this.date, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}