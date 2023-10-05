package com.studiosol.cifraclub.shazam.audioManager;

public abstract class AudioRecorder {

    protected AudioRecorderListener audioRecorderListener;

    public void setAudioRecorderListener(AudioRecorderListener audioRecorderListener) {
        this.audioRecorderListener = audioRecorderListener;
    }

    public abstract void startRecord();

    public abstract void stopRecord();

    public abstract void initAudioRecord();
}
