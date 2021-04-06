// https://javiercbk.github.io/json_to_dart/
import 'package:github_client_app/models/user.dart';

class Repo {
    int id;
    String name;
    String fullName;
    User owner;
    String parent;
    bool private;
    String htmlUrl;
    String description;
    bool fork;
    String homepage;
    String language;
    int forksCount;
    int stargazersCount;
    int watchersCount;
    int size;
    String defaultBranch;
    int openIssuesCount;
    List<String> topics;
    bool hasIssues;
    bool hasProjects;
    bool hasWiki;
    bool hasPages;
    bool hasDownloads;
    String pushedAt;
    String createdAt;
    String updatedAt;
    Permissions permissions;
    int subscribersCount;
    License license;

    Repo(
        {this.id,
            this.name,
            this.fullName,
            this.owner,
            this.parent,
            this.private,
            this.htmlUrl,
            this.description,
            this.fork,
            this.homepage,
            this.language,
            this.forksCount,
            this.stargazersCount,
            this.watchersCount,
            this.size,
            this.defaultBranch,
            this.openIssuesCount,
            this.topics,
            this.hasIssues,
            this.hasProjects,
            this.hasWiki,
            this.hasPages,
            this.hasDownloads,
            this.pushedAt,
            this.createdAt,
            this.updatedAt,
            this.permissions,
            this.subscribersCount,
            this.license});

    Repo.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        name = json['name'];
        fullName = json['full_name'];
        owner = json['owner'];
        parent = json['parent'];
        private = json['private'];
        htmlUrl = json['html_url'];
        description = json['description'];
        fork = json['fork'];
        homepage = json['homepage'];
        language = json['language'];
        forksCount = json['forks_count'];
        stargazersCount = json['stargazers_count'];
        watchersCount = json['watchers_count'];
        size = json['size'];
        defaultBranch = json['default_branch'];
        openIssuesCount = json['open_issues_count'];
        topics = json['topics'].cast<String>();
        hasIssues = json['has_issues'];
        hasProjects = json['has_projects'];
        hasWiki = json['has_wiki'];
        hasPages = json['has_pages'];
        hasDownloads = json['has_downloads'];
        pushedAt = json['pushed_at'];
        createdAt = json['created_at'];
        updatedAt = json['updated_at'];
        permissions = json['permissions'] != null
            ? new Permissions.fromJson(json['permissions'])
            : null;
        subscribersCount = json['subscribers_count'];
        license =
        json['license'] != null ? new License.fromJson(json['license']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['full_name'] = this.fullName;
        data['owner'] = this.owner;
        data['parent'] = this.parent;
        data['private'] = this.private;
        data['html_url'] = this.htmlUrl;
        data['description'] = this.description;
        data['fork'] = this.fork;
        data['homepage'] = this.homepage;
        data['language'] = this.language;
        data['forks_count'] = this.forksCount;
        data['stargazers_count'] = this.stargazersCount;
        data['watchers_count'] = this.watchersCount;
        data['size'] = this.size;
        data['default_branch'] = this.defaultBranch;
        data['open_issues_count'] = this.openIssuesCount;
        data['topics'] = this.topics;
        data['has_issues'] = this.hasIssues;
        data['has_projects'] = this.hasProjects;
        data['has_wiki'] = this.hasWiki;
        data['has_pages'] = this.hasPages;
        data['has_downloads'] = this.hasDownloads;
        data['pushed_at'] = this.pushedAt;
        data['created_at'] = this.createdAt;
        data['updated_at'] = this.updatedAt;
        if (this.permissions != null) {
            data['permissions'] = this.permissions.toJson();
        }
        data['subscribers_count'] = this.subscribersCount;
        if (this.license != null) {
            data['license'] = this.license.toJson();
        }
        return data;
    }
}

class Permissions {
    bool admin;
    bool push;
    bool pull;

    Permissions({this.admin, this.push, this.pull});

    Permissions.fromJson(Map<String, dynamic> json) {
        admin = json['admin'];
        push = json['push'];
        pull = json['pull'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['admin'] = this.admin;
        data['push'] = this.push;
        data['pull'] = this.pull;
        return data;
    }
}

class License {
    String key;
    String name;
    String spdxId;
    String url;
    String nodeId;

    License({this.key, this.name, this.spdxId, this.url, this.nodeId});

    License.fromJson(Map<String, dynamic> json) {
        key = json['key'];
        name = json['name'];
        spdxId = json['spdx_id'];
        url = json['url'];
        nodeId = json['node_id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['key'] = this.key;
        data['name'] = this.name;
        data['spdx_id'] = this.spdxId;
        data['url'] = this.url;
        data['node_id'] = this.nodeId;
        return data;
    }
}
