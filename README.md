ccReactorMonitor
================
IC2 Reactor automation using ComputerCraft and OpenPeripherals.  
Support for storage from AE-mod, Iron Chest, and EnderStorage  
  
* This script is currently designed to work with a single Reactor and single
  storage only.  
* Multiple batteries can be used, however the program will simply total up the
  current/max capacities for determining when to turn the reactor on/off.  
* The storage block MUST currently be _below_ the Reactor block that has the modem
  attached, this is a design limitation intended to utilize empty space created
  by the shape of a full 6 chamber reactor. I plan to attempt auto-detection in
  the future.  
* DO NOT change the internal layout of a reactor while this program is running.
  the program takes inventory when it first starts up and does not rescan while
  running. The reactor scan takes a few seconds which could cause lag if it
  constantly rescanned.  
* I recommend using an AND gate and a lever (or othertoggle) to create a master
  power switch.  
  
Future Enhancements
-------------------
* Configuration of reactor, battery and storage groups allowing separate control
  over multiple reactors.  
* Individual customization of displays (both monitors and bridges).  
* More robust graphical elements (meters, indicators, etc.).  
* Touch panel configuration.  
