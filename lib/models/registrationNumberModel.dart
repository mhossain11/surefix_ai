class RegistrationNumberModel {
  String? registrationNumber;
  String? make;
  String? model;
  String? colour;
  String? fuelType;
  int? engineCapacity;
  int? yearOfManufacture;
  String? vehicleAge;
  String? wheelplan;
  String? dateOfLastV5CIssued;
  String? typeApproval;
  int? co2Emissions;
  String? registrationPlace;
  Tax? tax;
  Mot? mot;

  RegistrationNumberModel(
      {this.registrationNumber,
        this.make,
        this.model,
        this.colour,
        this.fuelType,
        this.engineCapacity,
        this.yearOfManufacture,
        this.vehicleAge,
        this.wheelplan,
        this.dateOfLastV5CIssued,
        this.typeApproval,
        this.co2Emissions,
        this.registrationPlace,
        this.tax,
        this.mot});

  RegistrationNumberModel.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registrationNumber'];
    make = json['make'];
    model = json['model'];
    colour = json['colour'];
    fuelType = json['fuelType'];
    engineCapacity = json['engineCapacity'];
    yearOfManufacture = json['yearOfManufacture'];
    vehicleAge = json['vehicleAge'];
    wheelplan = json['wheelplan'];
    dateOfLastV5CIssued = json['dateOfLastV5CIssued'];
    typeApproval = json['typeApproval'];
    co2Emissions = json['co2Emissions'];
    registrationPlace = json['registrationPlace'];
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    mot = json['mot'] != null ? new Mot.fromJson(json['mot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationNumber'] = this.registrationNumber;
    data['make'] = this.make;
    data['model'] = this.model;
    data['colour'] = this.colour;
    data['fuelType'] = this.fuelType;
    data['engineCapacity'] = this.engineCapacity;
    data['yearOfManufacture'] = this.yearOfManufacture;
    data['vehicleAge'] = this.vehicleAge;
    data['wheelplan'] = this.wheelplan;
    data['dateOfLastV5CIssued'] = this.dateOfLastV5CIssued;
    data['typeApproval'] = this.typeApproval;
    data['co2Emissions'] = this.co2Emissions;
    data['registrationPlace'] = this.registrationPlace;
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    if (this.mot != null) {
      data['mot'] = this.mot!.toJson();
    }
    return data;
  }
}

class Tax {
  String? taxStatus;
  String? taxDueDate;
  String? days;

  Tax({this.taxStatus, this.taxDueDate, this.days});

  Tax.fromJson(Map<String, dynamic> json) {
    taxStatus = json['taxStatus'];
    taxDueDate = json['taxDueDate'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxStatus'] = this.taxStatus;
    data['taxDueDate'] = this.taxDueDate;
    data['days'] = this.days;
    return data;
  }
}

class Mot {
  String? motStatus;
  String? motDueDate;
  int? days;

  Mot({this.motStatus, this.motDueDate, this.days});

  Mot.fromJson(Map<String, dynamic> json) {
    motStatus = json['motStatus'];
    motDueDate = json['motDueDate'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['motStatus'] = this.motStatus;
    data['motDueDate'] = this.motDueDate;
    data['days'] = this.days;
    return data;
  }
}
