# MyROS2 cheatsheet based on `BotBuilder` YT tutorial series
https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp

## Video 1
https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=1
### Check if ros is installed properly 
```
printenv | grep -i ROS
```

### Each time every new terminal tab is open

ROS2 instalation workspace
```sh
sudo apt install ros-foxy-
```

source the setup script
```sh
source /opt/ros/foxy/setup.bash
```

This can be automated using:
```sh
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
```
## Video 2
https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=2

### Coommands
| ROS1 Commands         | ROS2 Commands     | Info |
| :-------              | :-------          |:-------           | 
| `rospack list-names`  | `ros2 pkg list`   |Show the list of packages|
| ---                   | `ros2 pkg executables <package_name>` | Output a list of executables from the packege|
|                       | `rqt`             | Startup rqt gui   |

### RQT 
RQT is is a very usefiæ gui for ROS

## Video 3 Understanding ROS packages and workspace
https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=3

### ROS2 local workspace
Make your own packages or download them from internet
```sh
cd <workspace_root_folder>
source install/setup.bash

```
create `src` folder and go to it
```
cd <workspace_root_folder>/src
```


create package C++
```sh
ros2 pkg create --build-type ament_cmake --node-name my_node my_package_cpp
```

create package Python
```sh
ros2 pkg create --build-type ament_python --node-name my_node my_package_py
```

return to `workspace_root_folder`
```sh
cd <workspace_root_folder>
```

build packages using `colcon`
```
colcon build
```

Source the packages
```sh
source insall/setup.bash
```

Run the packages
```
ros2 run my_package_cpp my_node
ros2 run my_package_py my_node
```

## Video 4 ROS executables and nodes
https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=4

IMPORTANT: exwcutable contains nodes

| ROS1 Commands         | ROS2 Commands     | Info |
| :-------              | :-------          |:-------           | 
| -                     | `ros2 pkg executables <package_name>` | |
| `rosrun <package_name> <executable_name>` | `ros2 run <package_name> <executable_name>` | |
| `rosnode list`        | `ros2 node list`  | |
| `rosnode info <node_name>` | `ros2 node info <node_name>`  | |


### Turtlesim example

run turtlesim gui
```sh
ros2 run turtlesim turtlesim_node
```

run turtlesim keyboard controller
```sh
ros2 run turtlesim turtle_teleop_key
```

draw squares
```sh
ros2 run turtlesim draw_square
```

show, which nodes are running
```sh
code
```
get more info about the node
```
ros2 node info <node_name>
```

To get map of nodes open `~$ rqt` and go to `Plugins>Introspection>Node graph`


## Video 5 ROS publisher, subscriber, topic

https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=5

Getting info about nodes
```
ros2 node list
ros2 node info <node_name>
```
At the moment we have 2 nodes running: `/draw_square` and `/turtlesim`

### Example:

Command `~$ ros2 node info /turtlesim` gives:
```
ros2 node info /turtlesim
/turtlesim
  Subscribers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
    /turtle1/cmd_vel: geometry_msgs/msg/Twist
  Publishers:
    /parameter_events: rcl_interfaces/msg/ParameterEvent
    /rosout: rcl_interfaces/msg/Log
    /turtle1/color_sensor: turtlesim/msg/Color
    /turtle1/pose: turtlesim/msg/Pose
  Service Servers:
    /clear: std_srvs/srv/Empty
    /kill: turtlesim/srv/Kill
    /reset: std_srvs/srv/Empty
    /spawn: turtlesim/srv/Spawn
    /turtle1/set_pen: turtlesim/srv/SetPen
    /turtle1/teleport_absolute: turtlesim/srv/TeleportAbsolute
    /turtle1/teleport_relative: turtlesim/srv/TeleportRelative
    /turtlesim/describe_parameters: rcl_interfaces/srv/DescribeParameters
    /turtlesim/get_parameter_types: rcl_interfaces/srv/GetParameterTypes
    /turtlesim/get_parameters: rcl_interfaces/srv/GetParameters
    /turtlesim/list_parameters: rcl_interfaces/srv/ListParameters
    /turtlesim/set_parameters: rcl_interfaces/srv/SetParameters
    /turtlesim/set_parameters_atomically: rcl_interfaces/srv/SetParametersAtomically
  Service Clients:

  Action Servers:
    /turtle1/rotate_absolute: turtlesim/action/RotateAbsolute
  Action Clients:
```
to get the linear and angular velocity (I guess), use:

```
~$ros2 interface proto geometry_msgs/msg/Twist
```

Output:
```
"linear:
  x: 0.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0
"
```

### Topic

by executing `~$ ros2 topic -h` we get list of commands:

```
Commands:
  bw     Display bandwidth used by topic
  delay  Display delay of topic from timestamp in header
  echo   Output messages from a topic
  find   Output a list of available topics of a given type
  hz     Print the average publishing rate to screen
  info   Print information about a topic
  list   Output a list of available topics
  pub    Publish a message to a topic
  type   Print a topic's type
```

Publish a message using `ros2 topic pub (optional argument (-1 is once -r 1 is continuous publishing with 1Hz) <topic_name> <message_type> value`:

```
ros2 topic pub -r 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "linear:
  x: 2.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 2.0
"
```
The above makes the turtle to circle indefinitely



Print messages within the topics `cmd_vel` and `pose`
```
ros2 topic echo /turtle1/cmd_vel
ros2 topic echo /turtle1/pose
```

Get information on the topic
```
ros2 topic info /turtle1/cmd_vel
```

Find the average publishing rate of topic `/turtle1/pose`
```
ros2 topic hz /turtle1/pose
```
## ROS2 Services
TODO: continue watching https://www.youtube.com/watch?v=bFDfvKctvV8&list=PLRE44FoOoKf7NzWwxt3W2taZ7BiWyfhCp&index=6

# My `.md` templates
## codebox template
```sh
ros2 node list
```

## List template
### Bullets
* item
* item
    * subitem
        * subsubitem
* item

### Ordered
1. item
1. item
1. item
    1. subitem
        1. subsubitem
        1. subsubitem
    1. subitem


## Table template
| ROS1 Commands        | ROS2 Commands    | Info |
| :-------              | :-------          |:-------           | 
| `code` | `code` | text |