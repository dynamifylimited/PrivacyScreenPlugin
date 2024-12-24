/**
 * PrivacyScreenPlugin.java Cordova Plugin Implementation
 * Created by Tommy-Carlos Williams on 18/07/14.
 * Copyright (c) 2014 Tommy-Carlos Williams. All rights reserved.
 * MIT Licensed
 */
package com.dynamify.privacyscreen;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;

import android.app.Activity;
import android.view.Window;
import android.view.WindowManager;

import org.json.JSONArray;
import org.json.JSONException;

/**
 * This class sets the FLAG_SECURE flag on the window to make the app
 * private when shown in the task switcher
 */
public class PrivacyScreenPlugin extends CordovaPlugin {

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        // Activity activity = this.cordova.getActivity();
        // activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
        CordovaInterface cordova = this.cordova;
        if (action.equals("disable")) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                public void run() {
                    try {
                        // Allow screenshots by removing the FLAG_SECURE
                        cordova.getActivity().getWindow().clearFlags(WindowManager.LayoutParams.FLAG_SECURE);
                        callbackContext.success("Success");
                    } catch (Exception e) {
                        callbackContext.error(e.toString());
                    }
                }
            });

            return true;
        } else if (action.equals("enable")) {
            cordova.getActivity().runOnUiThread(new Runnable() {
                public void run() {
                    try {
                        // Block screenshots by adding the FLAG_SECURE
                        cordova.getActivity().getWindow().setFlags(
                                WindowManager.LayoutParams.FLAG_SECURE,
                                WindowManager.LayoutParams.FLAG_SECURE
                        );
                        callbackContext.success("Success");
                    } catch (Exception e) {
                        callbackContext.error(e.toString());
                    }
                }
            });
            return true;
        } else {
            return false;
        }

    }
}
