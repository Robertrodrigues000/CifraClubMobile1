class UserDataDto {
  final int? userID;
  final String? name;
  final String? birth;
  final String? avatarURL;
  final String? coverURL;
  final int? coverPosition;
  final int? cityID;
  final String? cityName;
  final int? countryID;
  final String? countryName;
  final String? id;
  final int? stateID;
  final String? stateInitials;
  final String? email;
  final String? gender;
  final bool? passwordDefined;
  final bool? verified;
  final String? pendingEmail;

  const UserDataDto({
    this.userID,
    this.name,
    this.birth,
    this.avatarURL,
    this.coverURL,
    this.coverPosition,
    this.cityID,
    this.cityName,
    this.countryID,
    this.countryName,
    this.id,
    this.stateID,
    this.stateInitials,
    this.email,
    this.gender,
    this.passwordDefined = false,
    this.verified = false,
    this.pendingEmail,
  });

  UserDataDto.fromJson(Map data)
      : this(
          userID: data['userID'],
          name: data['name'],
          birth: data['birthdate'] ?? data['birth'],
          avatarURL: data['avatarUrl'] ?? data['avatarURL'],
          coverURL: data['coverURL'],
          coverPosition: data['coverPosition'],
          cityID: data['cityID'],
          cityName: data['cityName'],
          countryID: data['countryID'],
          countryName: data['countryName'],
          id: data['id'],
          stateID: data['stateID'],
          stateInitials: data['stateInitials'],
          email: data['email'],
          gender: data['gender'],
          passwordDefined: data['passwordDefined'],
          verified: data['verified'],
          pendingEmail: data['pendingEmail'],
        );
}
