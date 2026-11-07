# Apex Grid

**Own the race. Master the strategy. Become the champion.**

An original, single-player-first motorsport management game prototype designed for mobile and desktop browsers.

## Version 0.6.0 — Rival Teams & Championship Depth

- Three rival teams now have named drivers, distinct racing identities, strengths, tyre wear profiles, and strategic pit windows.
- Rival pace responds to circuit characteristics, tyre condition, and compound choice.
- Rival teams make their own planned pit stops during the race, with timing trade-offs.
- Expanded the championship from five to eight original circuits, adding Forest 400, Sunset Sprint, and Capital Grand Prix.
- Season-to-season career progression: complete an eight-round campaign and launch a new season while retaining car development, staff, facilities, driver growth, credits, reputation, and career points.
- Rival intelligence cards show each team, driver, specialist identity, and current-season points.
- Race results now include best-lap and average-lap analysis.
- Version 0.5 race setup, compounds, safety car, telemetry, and all prior management systems retained.

## Version 0.5.0 — Deeper Race Simulation

- Pre-race car setup choices for front wing, suspension and gearing, with circuit-sensitive performance trade-offs.
- Soft, medium and hard tyre compounds with distinct pace and degradation characteristics.
- Race-control safety car incidents with strategic pit-under-safety-car or stay-out decisions.
- Live lap telemetry showing lap time, estimated gap and tyre condition.
- Persistent recent race history, including round, event, finish and points.
- Version 0.4 driver progression, staff, facilities, sponsors and championship systems retained.

## Version 0.4.0 — Drivers & Team Operations

- Lead driver attributes (pace, control, focus, racecraft), experience, levels, and paid training.
- Driver development feeds into race performance and grows through championship participation.
- Recruitable performance engineer, race strategist, and commercial manager with gameplay bonuses.
- Three upgradeable team facilities: driver simulator, advanced workshop, and performance centre.
- Sponsorship contracts with race-completion objectives, credit rewards, and reputation gains.
- Team reputation progression shaped by race results and investment.
- Version 0.3 championship, qualifying, circuits, garage and race systems retained.

## Version 0.3.0 — Race Weekend & Championship

- Five-round championship across five original circuits with distinct lap counts and track characteristics.
- Qualifying before each race, with a starting grid position based on car performance and a flying-lap roll.
- Dynamic circuit details: event name, distance, corner count, lap count, and forecast.
- Weather and track effects: hot conditions increase tyre wear; wet conditions alter the degradation profile.
- Circuit specialisms: engine, handling, or aerodynamic upgrades provide small advantages on suitable tracks.
- Constructors standings for Apex Motorsport and three rival teams.
- Season finale after round five, with championship points and final standings.
- Retains the Version 0.2 garage, component upgrades, credits, rewards, and local career save.

## Run it

Open `index.html` in a modern browser. No build tools or dependencies are required. Progress is saved in the current browser/device using local storage. Existing Version 0.5 career saves are migrated when available.

## Files

- `index.html` — game screens and interface.
- `style.css` — responsive visual design.
- `game.js` — championship, qualifying, setup, tyre strategy, race simulation, team operations, telemetry, and career history.

## Prototype limitations

- Qualifying and race outcomes are simulated locally; there is no server-side simulation.
- Saves are tied to the current browser/device and are not synced across devices.
- Weather is represented by event forecasts and tyre-wear modifiers rather than live weather simulation.
- Online multiplayer and cloud saves are not implemented yet.

## Roadmap

### 0.7 — Career & Race Presentation
- Deeper driver market and rival-driver progression.
- More varied race-control incidents and strategy outcomes.
- Expanded season objectives, awards, and career records.
- Additional visual polish and mobile usability improvements.

### Later
- Cloud saves and account-based progression.
- Leaderboards, ghost races, and online multiplayer.
- Installable mobile app packaging and device testing.

Apex Grid uses original naming, interface design, and game systems. It is inspired by the motorsport-management genre, not a recreation of another game's branding, assets, or code.