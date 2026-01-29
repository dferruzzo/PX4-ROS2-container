# README

No container `PX4` rodar: 

```
make px4_sitl gazebo-classic
```

No container `ROS2` iniciar o agente para conectar o `uXRCE-DDS`:

```
MicroXRCEAgent udp4 -p 8888
```

## References

- [PX4-ROS2-main](https://docs.px4.io/main/en/ros2/)
- [PX4-ROS2-User-guide](https://docs.px4.io/main/en/ros2/user_guide)
- [PX4-ROS2-App](https://docs.px4.io/main/en/ros2/user_guide#ros-2-example-applications)

## Commands

cd ~/px4_ros2_ws
source /opt/ros/foxy/setup.bash
colcon build --symlink-install
source install/setup.bash

Start the agent with settings for connecting to the uXRCE-DDS client running on the simulator:

```
MicroXRCEAgent udp4 -p 8888
```

cd PX4-Autopilot
make px4_sitl_rtps gazebo

