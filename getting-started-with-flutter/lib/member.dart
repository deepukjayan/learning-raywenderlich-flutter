class Member {
  final String login;
  final String avatarURI;

  Member(this.login, this.avatarURI) {
    if (login == null) {
      throw ArgumentError("login of Member cannot be null. "
          "Received: '$login'");
    }
    if (avatarURI == null) {
      throw ArgumentError("avatarURL of member cannot be null."
          "Received: '$avatarURI'");
    }
  }
}
