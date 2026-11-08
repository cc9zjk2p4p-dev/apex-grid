# Apex Grid

**Own the race. Master the strategy. Become the champion.**

An original, single-player-first motorsport management game prototype designed for mobile and desktop browsers.

## Version 1.3.0 — Animated Paddock & Broadcast Race Control

- Added an animated garage paddock strip with a team car and active pit-crew silhouettes.
- Expanded live circuit scenery with trackside structures and a start/finish gantry.
- Added a race-control broadcast strip that reports green-flag laps, safety-car periods, virtual safety car calls, yellow flags, pit releases, and restart decisions.
- Added live position-change callouts when the player gains or loses a place, alongside the existing live leaderboard and constructors points tower.
- Preserved the Version 1.2 evolving car visuals, damage model, pit repair, replay snapshots, and full career/championship progression.
- Save migration advances from Version 1.2 to Version 1.3.

## Version 1.0.0 — Race Broadcast & Career Presentation

- Added a five-light race-start sequence with a lights-out launch, live race-state messaging, and a reduced-motion timing path.
- Added three broadcast camera presentations that can be cycled during live racing.
- Added a pit-stop broadcast moment with animated crew overlay and visual car emphasis while fresh tyres are fitted.
- Added an animated post-race podium presentation.
- Preserved the eight-round championship, team identity, sponsor negotiations, accessibility preferences, career archive, achievements, and rival development.
- Save migration advances from Version 0.9 to Version 1.0.

## Version 0.8.0 — Team Identity & Long-Term Career

- Custom team name and primary colour, reflected in team and race presentation.
- Team identity is saved with the career and carried across seasons.
- Sponsor negotiations let you choose between three contracts with different race targets and payouts; changing terms forfeits current contract progress.
- New race-experience settings: optional sound feedback, reduced motion, and high-contrast interface mode.
- Career achievement tracking for first victory, first podium, five wins, career points milestones, and completed seasons.
- Rival teams improve their pace gradually after each completed season.
- Driver market refreshes after each season, with improved prospects and rising recruitment costs.
- Version 0.7 driver market, career archive, race-control incidents, eight-round calendar, and all previous management systems retained.

## Version 0.7.0 — Career & Race Presentation

- Driver market with three recruitable prospects, distinct attributes, signing costs, and lead-driver replacement.
- Career archive tracks wins, podiums, poles, fastest laps, and career championship points.
- Season awards recognise constructors champions, race winners, podium consistency, and completed campaigns.
- More varied race-control incidents: safety car, virtual safety car, and local yellow-flag decisions with meaningful trade-offs.
- Race presentation polish: animated live timing markers and responsive career and driver panels.
- Corrected eight-round season gating and sponsor targets throughout event and team interfaces.
- Version 0.6 rival teams, strategic pit windows, eight-circuit calendar, and season progression retained.

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

Open `index.html` in a modern browser. No build tools or dependencies are required. Progress is saved in the current browser/device using local storage. Existing Version 1.2 and earlier career saves are migrated when available.

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

### 1.4 — Race Weekend Immersion & Strategy Intelligence
- Expanded pit strategy planner with rival-stop prediction and tyre-life estimates.
- Race engineer radio messages and strategic recommendations.
- More dynamic circuit atmosphere and event-specific broadcast moments.

### Later
- Cloud saves and account-based progression.
- Leaderboards, ghost races, and online multiplayer.
- Installable mobile app packaging and device testing.

Apex Grid uses original naming, interface design, and game systems. It is inspired by the motorsport-management genre, not a recreation of another game's branding, assets, or code.