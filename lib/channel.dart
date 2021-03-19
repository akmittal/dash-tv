class Channel {
  String name;
  String logo;
  String url;
  String category;
  List<Language> languages;
  Tvg tvg;
  Channel(
      this.name, this.logo, this.url, this.category, this.languages, this.tvg);
  Channel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        logo = json["logo"],
        url = json["url"],
        category = json["category"], 
        languages = json["languages"] 
            .map<Language>((language)  {
            // print(Language.fromJson(language));

            return Language.fromJson(language);
            })
            .toList(),
        tvg = Tvg.fromJson(json["tvg"]); 
}

class Language {
  final String code;
  final String name;
  Language(this.code, this.name);
  Language.fromJson(Map<String, dynamic> json)
      : this.code = json["code"], 
        this.name = json["name"];
}

class Tvg {
  String id;
  String name;
  String url;
  Tvg.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.url = json["url"];
}
