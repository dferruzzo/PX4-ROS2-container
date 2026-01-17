#!/usr/bin/env bash

# Run the script with the following command
# ./px4-container.sh "make px4_sitl gazebo-classic" 

# Nome da imagem oficial do PX4
PX4_IMAGE="px4io/px4-dev-ros2-foxy:latest"
PX4_DIR="$HOME/PX4-Autopilot"
COMMAND="${*}"

echo "=== PX4 Docker SITL + Gazebo GUI ==="

# Verifica se o diretório PX4 existe
if [ ! -d "$PX4_DIR" ]; then
    echo "Erro: Diretório $PX4_DIR não encontrado!"
    echo "Clone o repositório primeiro: git clone https://github.com/PX4/PX4-Autopilot.git $PX4_DIR"
    exit 1
fi

# Remove container existente se houver
if docker ps -a --format '{{.Names}}' | grep -q "^PX4-ROS2$"; then
    echo "Removendo container existente..."
    docker rm -f PX4-ROS2 >/dev/null 2>&1
fi

# Permite acesso ao X server
xhost +local:docker >/dev/null

docker run -it --init --rm --privileged -u root \
    --entrypoint "" \
    -v $PX4_DIR:$PX4_DIR:rw \
    -w $PX4_DIR \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    -p 14570:14570/udp \
    --name="PX4-ROS2" $PX4_IMAGE \
    bash -c "echo 'user ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/nopasswd && chmod 0440 /etc/sudoers.d/nopasswd && usermod -aG sudo user && chown -R user:user $PX4_DIR && su - user -c 'export DISPLAY=$DISPLAY && cd $PX4_DIR && ${COMMAND:-bash}'"
xhost -local:docker >/dev/null

