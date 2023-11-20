# Peacock HITMAN Server Docker Container
This is a quick and dirty Docker Container for the [Peacock Project HITMAN Server Emulator](https://github.com/thepeacockproject/Peacock).

## How to Use
-Create a port mapping to the internal port 80 and launch the container
-On your local machine run the PeacockPatcher.exe and point it to the external IP/Port the Docker image is running on
-Launch the game and play!

The directories /Peacock/userdata and /Peacock/contractSessions are mounted as volumes so you can save your progress

## Files Used
- https://api.github.com/repos/thepeacockproject/Peacock/releases/latest
- https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-x64.tar.gz