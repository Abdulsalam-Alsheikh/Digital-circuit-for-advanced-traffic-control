# Digital circuit for advanced traffic control

This project implements a digital controller designed to manage traffic flow between multiple intersections by applying the green wave concept. The system aims to optimize traffic flow by coordinating traffic lights across several intersections, ensuring smooth passage of vehicles.

## Project Overview

This project aims to develop a digital controller that facilitates traffic flow between multiple intersections using the green wave concept. The green wave ensures that vehicles can pass through several intersections without stopping, providing smooth traffic flow.

The controller operates based on input from magnetic sensors placed at intersections. Four sensors are deployed at each intersection, and they provide real-time data that helps the controller adjust the traffic lights accordingly. The controller is designed using a Moor machine model, and the design is tested using ModelSim software.

The main file to execute the design on Quartus is greenWave_Controller.vhd.

## System Components
The system is structured into hierarchical components, each performing a specific task to ensure the smooth operation of the traffic controller. Below is a description of the main components:

Pulse Generator: Generates a continuous pulse when the first car crosses from the adjacent intersection, serving as an input to other components.
Timer Pulse Generator: Generates a pulse every second or every 5 seconds based on the state and whether the green wave condition is met.
State Machine (Moor): Consists of D flip-flops for memory elements, and a logic circuit that generates the next state based on the current state.
Output Logic: Directly connected to the output of the memory elements and controls the traffic light signals.

## Testing and Validation

The design was tested using ModelSim by simulating different traffic scenarios and validating the performance of the controller under various conditions. The state diagram for the Moor machine is included in the project's documentation for reference.

You can find a detailed RTL diagram in RTL.pdf, which provides an in-depth view of the circuit design.

![state machine of two crossRoads (9) (2)](https://github.com/user-attachments/assets/813cc483-8105-4cb4-adaf-f63ae5902905)

[image_2023-05-06_00-31-50](https://github.com/user-attachments/assets/62aecd42-4f48-40f4-ace0-9ddcb4429dc2)

[RTL.pdf](https://github.com/user-attachments/files/17071730/RTL.pdf)
