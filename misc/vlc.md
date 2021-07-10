
# MISC

## How to Record your Computer Desktop Screen with VLC Player
	Media > Open Capture Device > Capture mode: Desktop > Play

## How to Screen Record with Mouse Cursor using vlc
	Tools > Preferences, Click "All"
		Advanced Preferences > Input / Codecs > Screen > Mouse pointer image

# Record audio and video with VLC
	Download
		https://www.videohelp.com/download/UScreenCapturex642018.zip OR http://www.videohelp.com/download/UScreenCapture2015.zip (http://www.videohelp.com/tools/UScreenCapture)
		http://sourceforge.net/projects/screencapturer/files/
    VLC > View > Advanced Controls
    VLC > View > Status Bar
    CTRL+C (open capture device)
    Screen capture record (video device)
    Virtual audio capture (audio device)
    If applicable: go to advanced settings and change 4:3 into, 16:9. You can change the default 4:3 aspecto ratio:
	Next to play button, click arrow and choose “convert”
	Choose a destination filename, e.g. test.mp4
	Start recording…

	Or just use ShareX
		Task Settings >> Capture >> Screen Recorder >> Screen recording options >> Audio source > Install recorder button > install both ‘screen capture recorder‘ and ‘virtual audio capturer‘ for ShareX

# Command Line

Files (x86)\VideoLAN\VLC\vlc.exe" -I dummy -vvv %%a --sout=#transcode{vcodec=h264,vb=1024,acodec=mp4a,ab=192,channels=2,deinterlace}:standard{access=file,mux=ts,dst=%%a.mp4} vlc://quit

for %%a in (*.VOB) do "C:\Program Files\VideoLAN\VLC\vlc" -I dummy -vvv %%a --sout=#transcode{vcodec=h264,vb=1024,acodec=mp4a,ab=192,channels=2,deinterlace}:standard{access=file,mux=ts,dst=%%a.mpg} vlc://quit

vlc input.mpeg :sout=#transcode{vcodec=mp4v,acodec=mp4a,ab=128,channels=2,samplerate=44100}:file{dst=output.mp4}

vlc input.mpeg :sout=#transcode{vcodec=h264,acodec=mp4a,ab=128,channels=2,samplerate=44100}:file{dst=output.mp4}


vlc input "--video-filter=croppadd{cropbottom=100,cropleft=100,cropright=100}"
vlc input.avi --crop=1280*480+250+1219

vlc --sout=#transcode{vcodec=h264,vb=1024,acodec=mpga,ab=192,channels=2,deinterlace}:standard{access=file,mux=ts,dst=MyVid.mp4}

vlc -vvv screen:// :screen-fps=25 :screen-caching=100 --sout="#transcode{

vcodec=h264,venc=x264{keyint=12,scenecut=80,profile=veryslow,intra-refresh,tune=zerolatency,bframes=0},fps=12,vb=600,acodec=none}:rtp{sdp=rtsp://:8554/display-me}" --sout-keep

vlc -vvv input.mp4 --sout="#transcode{vfilter=croppadd{cropbottom=144,cropright=96,cropleft=96},vcodec=h264,acodec=mp4a,ab=128,channels=2,deinterlace}:standard{access=file,mux=ts,dst=cropped.mp4}" --sout-keep

vlc -I dummy -vvv --quiet input.mp4 --sout="#transcode{vfilter=croppadd{croptop=0,cropbottom=144,cropright=96,cropleft=96},vcodec=h264,acodec=mp4a,ab=128,channels=2,deinterlace}:standard{access=file,mux=mp4,dst=cropped.mp4}"

vlc input.mp4 --sout="#transcode{vfilter=croppadd{croptop=0,cropbottom=144,cropright=96,cropleft=96},vcodec=h264,acodec=mp4a,ab=128,channels=2,deinterlace}:standard{access=file,mux=mp4,dst=cropped.mp4}"

vlc input.mp4 -vvv --sout="#transcode{vfilter=croppadd{croptop=0,cropbottom=144,cropright=96,cropleft=96},vcodec=h264,acodec=mp4a,ab=128,channels=2,deinterlace}:standard{access=file,mux=mp4,dst=cropped.mp4}"
