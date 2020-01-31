class Mentions {
  String id;
  String username;
  String avatar;
  String discriminator;

  Mentions({this.id, this.username, this.avatar, this.discriminator});

  Mentions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    discriminator = json['discriminator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['discriminator'] = this.discriminator;
    return data;
  }
}
