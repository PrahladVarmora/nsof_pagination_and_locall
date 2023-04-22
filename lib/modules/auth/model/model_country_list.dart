/// A Dart class that is used to parse the JSON response from the API.
class ModelCountryList {
  List<CountryList>? countryList;

  ModelCountryList({this.countryList});

  ModelCountryList.fromJson(Map<String, dynamic> json) {
    if (json['country_list'] != null) {
      countryList = <CountryList>[];
      json['country_list'].forEach((v) {
        countryList!.add(CountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countryList != null) {
      data['country_list'] = countryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// A class that contains a list of countries.
/// A class that is used to parse the JSON data.
class CountryList {
  String? countryCode;
  String? countryName;
  String? countryFlag;

  CountryList({this.countryCode, this.countryName, this.countryFlag});

  CountryList.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
    countryFlag = json['country_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = countryCode;
    data['country_name'] = countryName;
    data['country_flag'] = countryFlag;
    return data;
  }
}
