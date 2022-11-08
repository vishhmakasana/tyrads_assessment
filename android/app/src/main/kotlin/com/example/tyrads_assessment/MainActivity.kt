package com.example.tyrads_assessment

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException


class MainActivity : FlutterActivity() {

    private val platformChannel = "tyrAdsAssessment/platformChannel"
    private val platformMethod = "getStepsInfo"
    private val fileName = "steps_info.json"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            platformChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == platformMethod) {
                val jsonFileString = getJsonDataFromAsset(applicationContext)
                if (jsonFileString != null) {
                    result.success(jsonFileString)
                } else {
                    result.error("404", "Json file not found or not able to read correctly", "")
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getJsonDataFromAsset(context: Context): String? {
        val jsonString: String
        try {
            jsonString = context.assets.open(fileName).bufferedReader().use { it.readText() }
        } catch (ioException: IOException) {
            ioException.printStackTrace()
            return null
        }
        return jsonString
    }

}
