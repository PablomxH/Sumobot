### Features

- Ultrasonic sensor (HC-SR05);
- Finit State Machine to control the robot;


# Sumobot project

![](https://img.shields.io/badge/build-vhdl-blue
) ![](https://img.shields.io/badge/develop-PLD-blue
) ![](https://img.shields.io/badge/Chip-MaxII-blue
) ![](https://img.shields.io/badge/software-Quartus-blue
) ![](https://img.shields.io/badge/build-fsm-blue
) ![](https://img.shields.io/badge/version-1.2-blue
)

**Table of Contents**

[TOCM]

[TOC]

##Ultrasonic Sensor  HC-SR05
It's a key component for providing distance-sensing capabilities to the robot:
The HC-SR05 Ultrasonic Sensor is a popular choice for sumo robots and other applications that require accurate distance detection.

- Transmitter: The transmitter emits ultrasonic waves, which are high-frequency sound waves that are beyond the range of human hearing. 

- Receiver: The receiver on the sensor listens for the echo of the ultrasonic waves. When the emitted sound waves hit an object, they bounce back toward the sensor. 

The HC-SR05 sensor is easy to use and provides precise distance measurements. It typically has a detection range of a few centimeters to several meters.

Overall, the HC-SR05 Ultrasonic Sensor is a valuable tool in the sumobot's arsenal, enabling it to interact with its environment and make strategic movements during competitions.

##Infrared sensor
An Infrared Line Follower Sensor for a sumobot designed to detect and follow lines on the ground. 
It consists of infrared emitters and detectors. When the sensor is placed close to the ground, the emitted infrared light reflects off the surface. By measuring the intensity of the reflected light, the sensor can determine whether it is over a line or not. 

##Finite State Machine
A Finite State Machine (FSM) used to control a sumobot is a simple but effective approach to manage the robot's behavior. Here's a brief description:

A Finite State Machine for a sumobot is a control system that divides the robot's behavior into different states. Each state represents a specific action or condition.

- Search: In this state, the robot looks for opponents or boundaries.
- Approach: When it detects an opponent, it transitions to the "Approach" state, moving closer to the opponent.
- Attack: Once it gets close enough, it enters the "Attack" state, initiating offensive actions like pushing or lifting.
- Retreat: If it's in danger or not making progress, it switches to the "Retreat" state, moving away from the opponent.

The transitions between states are based on sensor data. For instance, when an opponent is detected by an ultrasonic sensor, the robot switches from "Search" to "Approach."

## USB Blaster
Drivers for USB Blaster : https://drive.google.com/file/d/12VrMxbNCbq21ysZJNTrTCtWa-x5MYNCg/view?usp=sharing


#PLD Properties
                    
CPLD  | Altera/Intel MAXII EPM240T100C5
------------- | -------------
Supply voltage  | 5V DC
I/O logic voltage  | 3.3V
Logic elements  | 40 LE
Supports up to 150Mh  | 50Mhz on-board oscillator
Programming connector  | JTAG
Operating temperature  | 0-70ºC
