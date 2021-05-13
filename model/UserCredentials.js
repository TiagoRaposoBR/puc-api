
class UserCredentials {
    userkey;
    userpass;

    constructor(key, pass) {
        this.userkey = key;
        this.userpass = pass;
    }

    static parse(rawData) {
        if (rawData && rawData['userkey'] !== undefined && rawData['userpass'] !== undefined) {
            return new UserCredentials(rawData.userkey, rawData.userpass);
        } else {
            return null;
        }
    }
}

module.exports = UserCredentials;