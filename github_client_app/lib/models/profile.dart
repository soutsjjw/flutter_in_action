// https://javiercbk.github.io/json_to_dart/
import 'package:github_client_app/models/index.dart';

class Profile {
    User user;
    String token;
    int theme;
    CacheConfig cache;
    String lastLogin;
    String locale;

    Profile(
        {this.user,
            this.token,
            this.theme,
            this.cache,
            this.lastLogin,
            this.locale});

    Profile.fromJson(Map<String, dynamic> json) {
        user = json['user'];
        token = json['token'];
        theme = json['theme'];
        cache = json['cache'];
        lastLogin = json['lastLogin'];
        locale = json['locale'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['user'] = this.user;
        data['token'] = this.token;
        data['theme'] = this.theme;
        data['cache'] = this.cache;
        data['lastLogin'] = this.lastLogin;
        data['locale'] = this.locale;
        return data;
    }
}
