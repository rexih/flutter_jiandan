package cn.rexih.flutter.flutterjiandan;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void attachBaseContext(android.content.Context base) {
    super.attachBaseContext(base);
    android.support.multidex.MultiDex.install(this);
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
