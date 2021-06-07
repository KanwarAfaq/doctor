class SelectTestModel {
  List<Result> ? result;

  SelectTestModel({this.result});

  SelectTestModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String ?id;
  String ?pname;
  String ?name;
  String ?type;
  String ?typeId;

  Result({this.id, this.pname, this.name, this.type, this.typeId});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pname = json['pname'];
    name = json['name'];
    type = json['type'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pname'] = this.pname;
    data['name'] = this.name;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    return data;
  }
}
