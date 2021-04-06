// https://javiercbk.github.io/json_to_dart/
class User {
    String login;
    int id;
    String avatarUrl;
    String url;
    String type;
    bool siteAdmin;
    String name;
    String company;
    String blog;
    String location;
    String email;
    bool hireable;
    String bio;
    int publicRepos;
    int publicGists;
    int followers;
    int following;
    String createdAt;
    String updatedAt;
    int totalPrivateRepos;
    int ownedPrivateRepos;

    User(
        {this.login,
            this.id,
            this.avatarUrl,
            this.url,
            this.type,
            this.siteAdmin,
            this.name,
            this.company,
            this.blog,
            this.location,
            this.email,
            this.hireable,
            this.bio,
            this.publicRepos,
            this.publicGists,
            this.followers,
            this.following,
            this.createdAt,
            this.updatedAt,
            this.totalPrivateRepos,
            this.ownedPrivateRepos});

    User.fromJson(Map<String, dynamic> json) {
        login = json['login'];
        id = json['id'];
        avatarUrl = json['avatar_url'];
        url = json['url'];
        type = json['type'];
        siteAdmin = json['site_admin'];
        name = json['name'];
        company = json['company'];
        blog = json['blog'];
        location = json['location'];
        email = json['email'];
        hireable = json['hireable'];
        bio = json['bio'];
        publicRepos = json['public_repos'];
        publicGists = json['public_gists'];
        followers = json['followers'];
        following = json['following'];
        createdAt = json['created_at'];
        updatedAt = json['updated_at'];
        totalPrivateRepos = json['total_private_repos'];
        ownedPrivateRepos = json['owned_private_repos'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['login'] = this.login;
        data['id'] = this.id;
        data['avatar_url'] = this.avatarUrl;
        data['url'] = this.url;
        data['type'] = this.type;
        data['site_admin'] = this.siteAdmin;
        data['name'] = this.name;
        data['company'] = this.company;
        data['blog'] = this.blog;
        data['location'] = this.location;
        data['email'] = this.email;
        data['hireable'] = this.hireable;
        data['bio'] = this.bio;
        data['public_repos'] = this.publicRepos;
        data['public_gists'] = this.publicGists;
        data['followers'] = this.followers;
        data['following'] = this.following;
        data['created_at'] = this.createdAt;
        data['updated_at'] = this.updatedAt;
        data['total_private_repos'] = this.totalPrivateRepos;
        data['owned_private_repos'] = this.ownedPrivateRepos;
        return data;
    }
}
