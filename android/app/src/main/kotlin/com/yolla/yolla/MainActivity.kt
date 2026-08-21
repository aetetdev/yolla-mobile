package com.yolla.yolla

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
    }

    /**
     * Bildirim kanalını kurar.
     *
     * Android 8'den beri kanalsız bildirim gösterilmiyor ve FCM manifestte
     * yazan kanalı kendisi yaratmıyor: kanal yoksa bildirim sessizce
     * düşürülüyor. Uygulama jetonunu almak için zaten en az bir kez açılmak
     * zorunda, kanalı burada kurmak yetiyor.
     *
     * Kanal bir kez kurulduktan sonra adı ve açıklaması güncellenebiliyor ama
     * önemi kullanıcıya bırakılıyor — sistem, kullanıcının ayarını uygulamanın
     * ezmesine izin vermiyor. Bu yüzden her açılışta çağrılması zararsız.
     */
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val channel = NotificationChannel(
            getString(R.string.notification_channel_id),
            getString(R.string.notification_channel_name),
            NotificationManager.IMPORTANCE_DEFAULT,
        ).apply {
            description = getString(R.string.notification_channel_description)
        }

        getSystemService(NotificationManager::class.java)
            .createNotificationChannel(channel)
    }
}
