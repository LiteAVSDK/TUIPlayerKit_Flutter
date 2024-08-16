package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.engine;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;

import io.flutter.embedding.android.ExclusiveAppComponent;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.platform.PlatformPlugin;

public class FlutterViewEngine implements LifecycleObserver, ExclusiveAppComponent<Activity> {

    private FlutterView mFlutterView;
    private FlutterActivity mActivity;
    private PlatformPlugin mPlatformPlugin;
    private final FlutterEngine mEngine;

    public FlutterViewEngine(FlutterEngine engine) {
        mEngine = engine;
    }

    /**
     * This is the intersection of an available activity and of a visible [FlutterView]. This is
     * where Flutter would start rendering.
     */
    private void hookActivityAndView() {
        if (null != mActivity && null != mFlutterView) {
//            mPlatformPlugin = new PlatformPlugin(mActivity, mEngine.getPlatformChannel());
//            mEngine.getActivityControlSurface().attachToActivity(this, mActivity.getLifecycle());
            mFlutterView.attachToFlutterEngine(mEngine);
//            mActivity.getLifecycle().addObserver(this);
        }
    }

    /**
     * Lost the intersection of either an available activity or a visible
     * [FlutterView].
     */
    private void unhookActivityAndView() {
        if (null != mActivity && null != mFlutterView) {
            mActivity.getLifecycle().removeObserver(this);
            mEngine.getActivityControlSurface().detachFromActivity();
            if (null != mPlatformPlugin) {
                mPlatformPlugin.destroy();
                mPlatformPlugin = null;
            }
            mEngine.getLifecycleChannel().appIsDetached();
            mFlutterView.detachFromFlutterEngine();
        }
    }

    /**
     * Signal that a host `Activity` is now ready. If there is no [FlutterView] instance currently
     * attached to the view hierarchy and visible, Flutter is not yet rendering.
     * <p>
     * You can also choose at this point whether to notify the plugins that an `Activity` is
     * attached or not. You can also choose at this point whether to connect a Flutter
     * [PlatformPlugin] at this point which allows your Dart program to trigger things like
     * haptic feedback and read the clipboard. This sample arbitrarily chooses no for both.
     */
    public void attachToActivity(FlutterActivity activity) {
        mActivity = activity;
        if (null != mFlutterView) {
            hookActivityAndView();
        }
    }

    /**
     * Signal that a host `Activity` now no longer connected. If there were a [FlutterView] in
     * the view hierarchy and visible at this moment, that [FlutterView] will stop rendering.
     * <p>
     * You can also choose at this point whether to notify the plugins that an `Activity` is
     * no longer attached or not. You can also choose at this point whether to disconnect Flutter's
     * [PlatformPlugin] at this point which stops your Dart program being able to trigger things
     * like haptic feedback and read the clipboard. This sample arbitrarily chooses yes for both.
     */
    public void detachActivity() {
        if (null != mFlutterView) {
            unhookActivityAndView();
        }
        mActivity = null;
    }

    /**
     * Signal that a [FlutterView] instance is created and attached to a visible Android view
     * hierarchy.
     * <p>
     * If an `Activity` was also previously provided, this puts Flutter into the rendering state
     * for this [FlutterView]. This also connects this wrapper class to listen to the `Activity`'s
     * lifecycle to pause rendering when the activity is put into the background while the
     * view is still attached to the view hierarchy.
     */
    public void attachFlutterView(FlutterView flutterView) {
        mFlutterView = flutterView;
        if (null != mActivity) {
            hookActivityAndView();
        }
    }

    /**
     * Signal that the attached [FlutterView] instance destroyed or no longer attached to a visible
     * Android view hierarchy.
     * <p>
     * If an `Activity` was attached, this stops Flutter from rendering. It also makes this wrapper
     * class stop listening to the `Activity`'s lifecycle since it's no longer rendering.
     */
    public void detachFlutterView() {
        unhookActivityAndView();
        mFlutterView = null;
    }

    /**
     * Callback to let Flutter respond to the `Activity`'s resumed lifecycle event while both an
     * `Activity` and a [FlutterView] are attached.
     */
    @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
    private void resumeActivity() {
        if (mActivity != null) {
            mEngine.getLifecycleChannel().appIsResumed();
        }
        if (null != mPlatformPlugin) {
            mPlatformPlugin.updateSystemUiOverlays();
        }
    }

    /**
     * Callback to let Flutter respond to the `Activity`'s paused lifecycle event while both an
     * `Activity` and a [FlutterView] are attached.
     */
    @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
    private void pauseActivity() {
        if (mActivity != null) {
            mEngine.getLifecycleChannel().appIsInactive();
        }
    }

    /**
     * Callback to let Flutter respond to the `Activity`'s stopped lifecycle event while both an
     * `Activity` and a [FlutterView] are attached.
     */
    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    private void stopActivity() {
        if (mActivity != null) {
            mEngine.getLifecycleChannel().appIsPaused();
        }
    }

    // These events aren't used but would be needed for Flutter plugins consuming
    // these events to function.

    /**
     * Pass through the `Activity`'s `onRequestPermissionsResult` signal to plugins that may be
     * listening to it while the `Activity` and the [FlutterView] are connected.
     */
    void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (mActivity != null && mFlutterView != null) {
            mEngine.getActivityControlSurface().onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }

    /**
     * Pass through the `Activity`'s `onActivityResult` signal to plugins that may be
     * listening to it while the `Activity` and the [FlutterView] are connected.
     */
    void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (mActivity != null && mFlutterView != null) {
            mEngine.getActivityControlSurface().onActivityResult(requestCode, resultCode, data);
        }
    }

    /**
     * Pass through the `Activity`'s `onUserLeaveHint` signal to plugins that may be
     * listening to it while the `Activity` and the [FlutterView] are connected.
     */
    void onUserLeaveHint() {
        if (mActivity != null && mFlutterView != null) {
            mEngine.getActivityControlSurface().onUserLeaveHint();
        }
    }

    @Override
    public void detachFromFlutterEngine() {

    }

    @NonNull
    @Override
    public Activity getAppComponent() {
        return mActivity;
    }
}
