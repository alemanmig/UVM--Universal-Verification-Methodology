# UVM Enviroment for an SPI Memory

## Verification Environment Architecture

The verification environment follows a UVM-based layered structure, including sequencers, drivers, monitors, scoreboards, and coverage collectors. The environment is designed to support constrained-random testing and coverage-driven verification.

## UVM Components Overview

- **Environment (env):** Top-level container connecting all components.  
- **Agent:** Encapsulates the driver, monitor, and sequencer for the SPI interface.  
- **Driver:** Translates high-level sequence transactions into pin-level activity on the DUT.  
- **Monitor:** Passively observes SPI signals and collects transaction data.  
- **Sequencer:** Manages sequence execution and stimulus generation.  
- **Scoreboard:** Compares expected vs. actual results.  
- **Coverage Collector:** Tracks protocol-level functional coverage.  

<p align="center">
  <img src="images/UVM-SPI_Diagram.svg" width="60%"><br>
  <em>Figure 1: SPI Memory UVM Test Architecture</em>
</p>

### 3.3 Interface Agents
The SPI agent supports **active** and **passive** configurations. In active mode, it drives transactions through the `mosi` interface; in passive mode, it only monitors communication.

<p align="center">
  <img src="images/UVM-Agent.svg" width="60%"><br>
  <em>Figure 2: SPI UVM Agent</em>
</p>

