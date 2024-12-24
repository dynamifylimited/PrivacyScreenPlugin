var exec = require('cordova/exec');
var executeCallback = function(callback, message) {
    if (typeof callback === 'function') {
        callback(message);
    }
};


/**
 * Secures the app by blocking screenshots
 * @param {Function} [successCallback] - Optional success callback, receives message object.
 * @param {Function} [errorCallback] - Optional error callback, receives message object.
 * @returns {Promise}
 */
exports.enable = function(successCallback, errorCallback) {
    return new Promise(function(resolve, reject) {
        exec(function(message) {
            executeCallback(successCallback, message);
            resolve(message);
        }, function(message) {
            executeCallback(errorCallback, message);
            reject(message);
        }, 'PrivacyScreenPlugin', 'enable', []);
    });
};


/**
 * Removes screenshot blocking from the app
 * @param {Function} [successCallback] - Optional success callback, receives message object.
 * @param {Function} [errorCallback] - Optional error callback, receives message object.
 * @returns {Promise}
 */
exports.disable = function(successCallback, errorCallback) {
    return new Promise(function(resolve, reject) {
        exec(function(message) {
            executeCallback(successCallback, message);
            resolve(message);
        }, function(message) {
            executeCallback(errorCallback, message);
            reject(message);
        }, 'PrivacyScreenPlugin', 'disable', []);
    });
};

