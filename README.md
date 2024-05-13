# WI Expert Advisor v2.8

## Overview

WI Expert Advisor is a MetaTrader 5 (MQ5) Expert Advisor designed for automated trading across various markets. It utilizes signals based on RSI and EMA indicators to facilitate trading decisions.

## Features

### AutoTrading

- Optional for signals.
- Mandatory for automated trades.

### Timeframes

- All timeframes for RSI Boom & Crash signals.
- All timeframes for EMA (200) signals.
- Minimum timeframe of M5 for automated EMA (200) trades.

### Algorithm (Algo)

- Alerts for RSI 14 & 40 on M1, and EMA 200 on the current timeframe.
- Usage of Crash Index and Boom Index based on RSI levels.
- Cross of EMA 200 with the market for all other symbols.
- Cross of EMA 200 & EMA 7 for AutoTrades.

### Alerts

- RSI 14 & 40 alerts on M1.
- EMA 200 alerts on the current timeframe.

### Crash Index

- RSI 14 levels for Crash 1000 and Crash 500.
- RSI 40 levels for Crash 1000 and Crash 500.

### Boom Index

- RSI 14 levels for Boom.
- RSI 40 levels for Boom.

### Other Symbols

- Cross of EMA 200 with the market.
- Cross of EMA 200 & EMA 7 for AutoTrades.

### AutoTrades

- Signals usage for Boom & Crash trades.
- Minimum lot size for AutoTrades.
- Stop Loss set at -5 for all AutoTrades.

## Usage

1. Install MetaTrader 5 platform.
2. Place the Expert Advisor file in the "Experts" folder of MetaTrader 5.
3. Launch MetaTrader 5 and load the Expert Advisor onto a chart.
4. Configure settings according to trading preferences.
5. Enable AutoTrading for automated trades.

## Disclaimer

Trading involves risks and this Expert Advisor does not guarantee profits. Use it for demo purposes only.
