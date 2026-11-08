# Apex Grid — Godot 4 migration plan

## Direction

- Engine: Godot 4 (GDScript).
- First target: iOS, landscape orientation.
- Follow-on target: Android.
- Rendering: Godot Compatibility renderer for broad mobile device support.
- Architecture: native scenes and scripts; the browser prototype remains available during the transition.

## Milestone 0.1 — Native foundation

Implemented in this repository:

- Godot project configuration and main scene.
- Garage screen with engine, aerodynamics, and handling upgrades.
- Local save file using Godot ConfigFile under `user://`.
- Race Weekend screen with an animated top-down circuit, player car and four rivals.
- Eight-lap test session, start/pause controls, lap updates and a basic race-completion reward.
- Championship preview screen.

## Next migration milestones

1. **Race simulation parity:** migrate tyre compounds, degradation, pit stops, energy, damage, safety car and virtual safety car logic.
2. **Career and team systems:** migrate drivers, staff, facilities, sponsors, team identity, rival teams and the eight-round championship.
3. **Weather and strategy:** migrate changing weather, track grip, circuit incidents, stint planning, rival pit windows and engineer radio.
4. **Broadcast and replay:** migrate camera modes, race-control messages, timing tower, podium, lap snapshots and replay navigation.
5. **Mobile polish:** touch-first controls, safe-area layout, accessibility, audio, performance profiling and device testing.

## iOS build requirements

A signed iOS application requires a Mac running a compatible version of Xcode, Godot's iOS export templates, an Apple Developer signing setup, and a configured bundle identifier. Those credentials are deliberately not included in source control. Android export can be configured later with the Android SDK and export templates.

## Current limitations

- The native project is a foundation prototype, not feature-complete parity with the browser game.
- The championship view is currently a presentation placeholder.
- The race cars use procedural 2D drawing; final car art, track assets, sound and broadcast overlays are future work.
- No Godot editor import, device build, or on-device gameplay test has been performed in this environment. Open the project in Godot 4.3+ and run it to validate the imported project.
