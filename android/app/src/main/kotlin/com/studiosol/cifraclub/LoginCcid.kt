package com.studiosol.cifraclub

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.core.content.ContextCompat
import com.google.gson.Gson
import com.studiosol.loginccid.Backend.API.ApiCode
import com.studiosol.loginccid.Backend.API.GraphQLAPI
import com.studiosol.loginccid.Backend.AddRegIdData
import com.studiosol.loginccid.Backend.AppProvider
import com.studiosol.loginccid.Backend.RegIDInput
import com.studiosol.loginccid.Backend.Theme
import com.studiosol.loginccid.Backend.UserAuthNetwork
import com.studiosol.loginccid.Backend.UserData
import com.studiosol.loginccid.CCID
import com.studiosol.loginccid.Enums.AuthProviderType
import com.studiosol.loginccid.Interfaces.AuthListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import type.Platform

class LoginCcid : FlutterPlugin, MethodCallHandler, AuthListener, ActivityAware {

    private fun getTheme(context: Context): Theme {
        return Theme(
            ContextCompat.getColor(context, R.color.login_primary),
            ContextCompat.getColor(context, R.color.login_hover),
            ContextCompat.getDrawable(context, R.drawable.logo_cifra_club_alpha)!!,
            ContextCompat.getDrawable(context, R.drawable.login_bg)!!,
            ContextCompat.getColor(context, R.color.white),
            ContextCompat.getColor(context, R.color.white)
        )
    }

    companion object {
        const val LOGIN_CCID_CHANNEL = "com.studiosol.flutter/login_ccid"
        const val CIFRA_CLUB_TERMS = "https://m.cifraclub.com.br/aviso-legal.html"
        const val CIFRA_CLUB_PRIVACY_POLICY = "https://m.cifraclub.com.br/politica-privacidade.html"
    }

    private var activity: Activity? = null
    private var channel: MethodChannel? = null
    private var pendingResult: MethodChannel.Result? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
    }

    private fun onAttachedToEngine(context: Context, messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, LOGIN_CCID_CHANNEL).apply {
            setMethodCallHandler(this@LoginCcid)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        CCID.get().registerListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
        CCID.get().unregisterListener(this@LoginCcid)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (pendingResult != null) {
            pendingResult?.error("MULTIPLE_REQUESTS", "Cannot make multiple requests.", null)
            pendingResult = null
        }
        pendingResult = result
        when (call.method) {
            "initializeCcid" -> initializeCcid()
            "openLoginView" -> openLoginView()
            "logout" -> logout()
            "getUserData" -> getUserData()
            "getToken" -> getToken()
            "isUserLoggedIn" -> isUserLoggedIn()
            "resendEmail" -> resendEmail()
            "refreshUserData" -> refreshUserData()
            "addRegId" -> {
                var token = call.argument<String>("token")
                if ((token == null || token.isBlank()) && BuildConfig.DEBUG) {
                    if (BuildConfig.DEBUG) {
                        throw Exception("Empty token")
                    }
                    token = ""
                }
                token?.let { sendAddRegId(it) }
            }
        }
    }

    private fun initialize(context: Context) {
        CCID.get().apply {
            getTheme(context)?.let {
                setCCIDTheme(it)
            }
            init(
                context = context,
                appVersion = "${BuildConfig.VERSION_NAME} (${BuildConfig.VERSION_CODE})",
                googleAppId = context.getString(R.string.google_id_token),
                termsOfUse = LocaleHelper.buildUrlWithLocaleParam(CIFRA_CLUB_TERMS),
                privacyPolicy = LocaleHelper.buildUrlWithLocaleParam(CIFRA_CLUB_PRIVACY_POLICY),
                onInitializationFinished = {
                    pendingResult?.success(true)
                    pendingResult = null
                },
                regIDInput = RegIDInput(
                    regID = "",
                    instanceID = "",
                    app = context.packageName,
                    platform = Platform.ANDROID,
                    appProvider = AppProvider.CIFRACLUB,
                    facebookPermissions = listOf("public_profile", "email")
                ),
                showGoogleLogin = true,
                showFacebookLogin = true,
                appleClientId = "br.com.studiosol.CifraClubID.SignInWithApple",
                appleRedirectId = "https://id.cifraclub.com.br/auth/apple/callback"
            )
            disableAutoFill()
        }
    }

    private fun initializeCcid() {
        val activity = activity ?: return
        initialize(activity)
    }

    private fun openLoginView() {
        val activity = activity ?: return
        CCID.get().apply {
            getTheme(activity)?.let {
                setCCIDTheme(it)
            }
            showCCIDActivity(activity)
        }
        pendingResult?.success("...")
        pendingResult = null
    }

    private fun logout() {
        CCID.get().logout()
        pendingResult?.success("logging out...")
        pendingResult = null
    }

    private fun getUserData() {
        val userData = CCID.get().getUserData()
        if (userData != null) {
            pendingResult?.success(Gson().toJson(userData))
        } else {
            pendingResult?.success(null)
        }
        pendingResult = null
    }

    private fun getToken() {
        val token = CCID.get().getAuthToken()
        pendingResult?.success(token)
        pendingResult = null
    }

    private fun resendEmail() {
        val activity = activity ?: return
        UserAuthNetwork.get().resendEmailConfirmation(object : UserAuthNetwork.ChangeDataInterface {
            override fun onUserDataChanged(code: ApiCode) {
                if (code == ApiCode.NO_ERROR) {
                    activity.runOnUiThread {
                        Toast.makeText(
                            activity,
                            activity.getText(com.studiosol.loginccid.R.string.new_validate_email_success),
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                } else {
                    activity.runOnUiThread {
                        Toast.makeText(
                            activity,
                            activity.getText(com.studiosol.loginccid.R.string.new_validate_email_fail),
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                }
            }
        })
        pendingResult?.success("")
        pendingResult = null
    }

    private fun refreshUserData() {
        CCID.get().updateUserData()
        pendingResult?.success("")
        pendingResult = null
    }

    private fun isUserLoggedIn() {
        CCID.get().isUserLoggedIn()
        pendingResult?.success(CCID.get().isUserLoggedIn())
        pendingResult = null
    }

    private fun sendAddRegId(token: String) {
        val activity = activity ?: return
        val userData = CCID.get().getUserData()

        if (userData?.userID != null && userData.userID != 0) {
            val data = AddRegIdData()
            data.regId = token
            data.userId = userData.userID
            data.instanceId = token.split(":").firstOrNull() ?: ""
            data.app = activity.packageName

            GraphQLAPI.addRegId(
                data,
                object : GraphQLAPI.GraphQLAPIInterface {
                    override fun onRequestResult(code: ApiCode, data: Any) {}
                }
            )
        } else {
            print("Error to get addRegID input data.")
        }
        pendingResult?.success("")
        pendingResult = null
    }

    override fun onLoginComplete(userData: UserData, loginMethod: AuthProviderType) {
        Handler(Looper.getMainLooper()).post {
            channel?.invokeMethod(
                "onLoginComplete",
                hashMapOf(
                    "method" to loginMethod.name
                )
            )
        }
    }

    override fun onLogoutComplete() {
        Handler(Looper.getMainLooper()).post {
            channel?.invokeMethod("onLogoutComplete", "")
        }
    }

    override fun onUserDataChanged(userData: UserData) {
        Handler(Looper.getMainLooper()).post {
            channel?.invokeMethod("onUserDataChanged", Gson().toJson(userData))
        }
    }

    override fun onSilentLogoutComplete() {
        Handler(Looper.getMainLooper()).post {
            channel?.invokeMethod("onSilentLogoutComplete", "")
        }
    }
}