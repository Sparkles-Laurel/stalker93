class AccountState {
  final String? _username;
  final int? _follower, _followin, _posts;
  final DateTime _recordedAt;

  String? get username => _username;
  int? get followers => _follower;
  int? get following => _followin;
  int? get postCount => _posts;
  DateTime get recordedAt => _recordedAt;

  AccountState.recordNew(
      this._username, this._follower, this._followin, this._posts)
      : _recordedAt = DateTime.now();

  AccountState(this._username, this._follower, this._followin, this._posts,
      this._recordedAt);
}

class Account {
  final String? _username;
  final List<AccountState> _states = [];

  Account(this._username);

  void recordState(int followers, int following, int posts) {
    _states.add(AccountState.recordNew(_username, followers, following, posts));
  }

  void loadState(String username, int followers, int following, int posts,
      DateTime recordedAt) {
    _states
        .add(AccountState(username, followers, following, posts, recordedAt));
  }

  AccountState? get currentState {
    if (_states.isEmpty) return null;
    return _states.last;
  }

  AccountState? get previousState {
    if (_states.length < 2) return null;
    return _states[_states.length - 2];
  }
}
