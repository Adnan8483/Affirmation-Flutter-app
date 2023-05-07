/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class AffirmationList {
  int? id;
  String? affirmation;
  int? is_like;

  AffirmationList({this.id, this.affirmation, this.is_like});

  AffirmationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affirmation = json['affirmation'];
    is_like = json['is_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['affirmation'] = affirmation;
    data['is_like'] = is_like;
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
