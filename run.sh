 docker run -it --rm \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v $HOME/DownloadsWS:/home/banco/Downloads \
            -e DISPLAY=unix$DISPLAY \
            --name warsaw-browser \
	    gschanuel/bash

