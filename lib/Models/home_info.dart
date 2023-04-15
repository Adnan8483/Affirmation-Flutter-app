/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class AffirmationList {
  int? id;
  String? affirmation;

  AffirmationList({this.id, this.affirmation});

  AffirmationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affirmation = json['affirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['affirmation'] = affirmation;
    return data;
  }
}

class HomeInfo {
  List<AffirmationList?>? affirmationList;

  HomeInfo({this.affirmationList});

  HomeInfo.fromJson(Map<String, dynamic> json) {
    if (json['affirmation_List'] != null) {
      affirmationList = <AffirmationList>[];
      json['affirmation_List'].forEach((v) {
        affirmationList!.add(AffirmationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['affirmation_List'] = affirmationList != null
        ? affirmationList!.map((v) => v?.toJson()).toList()
        : null;
    return data;
  }
}
