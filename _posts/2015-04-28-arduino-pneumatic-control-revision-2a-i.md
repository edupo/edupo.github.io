---
layout: post
title: Arduino pneumatic control - revision 2a (I)
date: '2015-04-28 08:55:14 +0200'
categories:
  - uncategorized
tags:
  - Arduino
  - control
  - automation
  - pneumatics
  - duration
  - test
---

I had the opportunity to work around a small platform to perform duration tests using some pneumatic equipment. It consists of some Festo valves and cylinders and a small Arduino with some shields on it. After a brief revision of the schematics, I've started to improve the design. Using the same interfaces and pin-out to make it retro-compatible.

> If you can, and probably 'you can', make it retro compatible: just make it. Don't waste previous effort until you have a good reason.

This second revision consists of an upgrade on the sensor adaptation inputs to make their software configurable. Also, good documentation was added to the silkscreen layers. And detailed files and information were added to the project.

> Lack of documentation is the worst case for incoming engineers. So to keep it clean... Document all your changes.

This is the list of features:

- Controls up to 4 solenoids
- Measures up to 4 analog inputs
- LCD screen with the current status
- **Controllable sensing gain controlled by software**
- **Data login into SD card**
- **Selectable sensor voltage supply**
- **3 x 4 control keypad**
- **LCD controlled by I2C**
