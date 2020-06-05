package com.images.share.shareimages;

import android.app.Activity;
import android.content.Intent;
import android.content.Context;
import androidx.core.content.FileProvider;
import android.net.Uri;
import android.util.Log;
import java.util.ArrayList;
import android.util.Base64;
import android.graphics.BitmapFactory;
import android.graphics.Bitmap;
import java.io.File;
import android.os.StrictMode;
import android.os.Build;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;

class ShareImages extends ReactContextBaseJavaModule {

    Context context;

    public ShareImages(ReactApplicationContext reactContext) {
        super(reactContext);
        context = reactContext;
    }

    @Override
    public String getName() {
        return "ShareImages";
    }

    @ReactMethod
    public void show(ReadableMap options) {
        Boolean isMultiple = options.getArray("images").size() > 1;
        Intent intent = new Intent();
        StrictMode.VmPolicy oldVmPolicy = null;
        if (Build.VERSION.SDK_INT >= 24) {
            oldVmPolicy = StrictMode.getVmPolicy();
            StrictMode.VmPolicy policy = new StrictMode.VmPolicy.Builder().build();
            StrictMode.setVmPolicy(policy);
        }
        if (oldVmPolicy != null) {
            StrictMode.setVmPolicy(oldVmPolicy);
        }
        if(isMultiple) {
            intent.setAction(Intent.ACTION_SEND_MULTIPLE);
            if(options.hasKey("images")){
                ArrayList<Uri> uriList = new ArrayList<Uri>();
                for (int i = 0; i < options.getArray("images").size(); i++) {
                    Uri uri = Uri.parse("");
                    File imagePath = new File(context.getCacheDir(), options.getArray("cacheFileName").getString(i));
                    uri = FileProvider.getUriForFile(context, context.getPackageName() + ".fileprovider", imagePath);
                    uriList.add(uri);
                }
                intent.putParcelableArrayListExtra(Intent.EXTRA_STREAM, uriList);
                intent.setType("image/*");
            }
        } else {
            intent.setAction(Intent.ACTION_SEND);
            if(options.hasKey("images")){
                Uri imageUri = Uri.parse("");
                if(options.hasKey("cacheFileName")) {
                    File imagePath = new File(context.getCacheDir(), options.getArray("cacheFileName").getString(0));
                    imageUri = FileProvider.getUriForFile(context, context.getPackageName() + ".fileprovider", imagePath);
                } else {
                    imageUri = Uri.parse(options.getArray("images").getString(0));
                }
                intent.putExtra(Intent.EXTRA_STREAM, imageUri);
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                if(options.hasKey("isPDF")) {
                    intent.setType("application/pdf");
                } else {
                    intent.setType("image/jpg");
                }
            }
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        String _title = options.hasKey("title") ? options.getString("title") : "Share";
        Activity currentActivity = getCurrentActivity();
        if (currentActivity != null) {
            currentActivity.startActivity(Intent.createChooser(intent, _title));
        }
    }
}
