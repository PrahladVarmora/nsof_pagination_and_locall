/// The class is likely a model for a dashboard list item in a Dart application.
class ModelDashboardListItem {
  int? id;
  String? name;
  String? description;
  String? avatarUrl;
  int? watchersCount;
  String? language;
  bool? hasIssues;
  int? openIssuesCount;

  ModelDashboardListItem({
    this.id,
    this.name,
    this.description,
    this.avatarUrl,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.openIssuesCount,
  });

  ModelDashboardListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];

    if (json.containsKey('owner')) {
      avatarUrl = json['owner']['avatar_url'];
    } else {
      avatarUrl = json['avatar_url'];
    }
    if (json['watchers_count'] != null) {
      watchersCount = int.parse((json['watchers_count'] ?? 0).toString());
    }
    language = json['language'];
    if (json['has_issues'].runtimeType == bool) {
      hasIssues = json['has_issues'];
    } else {
      hasIssues = (json['has_issues'] ?? 0) == 1;
    }
    openIssuesCount = json['open_issues_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['avatar_url'] = avatarUrl;
    data['watchers_count'] = watchersCount;
    data['language'] = language;
    data['has_issues'] = (hasIssues ?? false) ? 1 : 0;
    data['open_issues_count'] = openIssuesCount;
    return data;
  }
}
