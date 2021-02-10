class Cast {
  List<Actor> actores;

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      actores = [];
      return;
    }
    actores = jsonList.map((jsonMap) => Actor.fromJsonMap(jsonMap)).toList();
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.gender,
    this.id,
    this.name,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  Actor.fromJsonMap(Map<String, dynamic> jsonMap) {
    gender = jsonMap['gender'];
    id = jsonMap['id'];
    name = jsonMap['name'];
    profilePath = jsonMap['profile_path'];
    castId = jsonMap['cast_id'];
    character = jsonMap['character'];
    creditId = jsonMap['credit_id'];
    order = jsonMap['order'];
  }

  getImage() {
    if (profilePath == null) {
      return 'https://www.speakandwrite.com.au/wp-content/uploads/2016/03/avatar.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
