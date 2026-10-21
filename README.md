# 🗺️ The Gradual Roadmap (Project by Project)

## Phase 0 — Foundation (No Flame yet)

* [x] [**Project 0: “Hello, Game Loop” (Pure Flutter)**](hello_game_loop/README.md)

---

## Phase 1 — Flame Fundamentals (One Concept Per Project)

### **Project 1: “Meteor Shower” (Components & Randomness)**

* **Objective:** Learn the component tree and lifecycle.
* **Tasks:**
* [ ] Create a `FlameGame` and add it to the widget tree.
* [ ] Create a `Meteor` class extending `PositionComponent` (or `SpriteComponent`).
* [ ] In `onLoad`, spawn meteors at random x-positions above the screen.
* [ ] In `update(dt)`, move them down. Remove them when off-screen.
* **Hint:** How does a component know it has been added to the game? What is `removeFromParent()`?
* **Resource:** Google Codelab: *Introduction to Flame with Flutter* (covers GameWidget, game loop, and components).

### **Project 2: “Brick Breaker” (Collision & Input)**

* **Objective:** Handle collisions and simple input.
* **Tasks:**
* [ ] Add `HasCollisionDetection` to your game class.
* [ ] Create a paddle that moves horizontally via `onDragUpdate` or `onPanUpdate`.
* [ ] Create a ball that bounces off walls (check position in `update`).
* [ ] Create bricks with `CollisionCallbacks`. When the ball hits a brick, remove the brick.
* **Hint:** What is the difference between `onCollisionStart` and `onCollision`? How do you stop the ball from passing through the paddle?
* **Resource:** Flame docs: *Collision Detection*.

### **Project 3: “Top-Down Walker” (Camera & Zoom)**

* **Objective:** Implement a camera that follows a player and zooms.
* **Tasks:**
* [ ] Create a large world (e.g., a big rectangle) and a small player square.
* [ ] Add a `CameraComponent` and a `World`. Make the camera follow the player smoothly (use `camera.follow(player)`).
* [ ] Add two UI buttons (Flutter `Overlay` widgets) to call `camera.viewfinder.zoomTo(...)` for zoom in/out.
* **Hint:** What is the relationship between the `World` and the `CameraComponent`? Why doesn't the UI zoom with the world?
* **Resource:** Flame docs: *Camera & Viewport*.

---

## Phase 2 — Core Game Mechanics (Shooter Primitives)

### **Project 4: “Twin-Stick Target Practice” (Two-Finger Controls & Shooting)**

* **Objective:** Implement independent movement and aiming.
* **Tasks:**
* [ ] Use a `JoystickComponent` (from `flame_joystick` package) for movement.
* [ ] Use `onPanUpdate` on the *right side* of the screen to aim (rotate the player toward the touch point).
* [ ] Spawn bullets (small components) from the player's position in the aim direction when a "Fire" button is held.
* [ ] Add targets that disappear when hit by bullets.
* **Hint:** How do you convert a touch position (screen coordinates) to a world direction? (Hint: `camera.globalToLocal`).
* **Resource:** Flame `flame_joystick` package docs.

### **Project 5: “Weapon & Inventory Manager” (State & Data)**

* **Objective:** Manage two weapon slots and ammo.
* **Tasks:**
* [ ] Create a `WeaponData` class (damage, fire rate, ammo capacity).
* [ ] Give the player two `WeaponData` slots. A button toggles the active slot.
* [ ] Shooting consumes ammo from the active weapon. When ammo is 0, the weapon cannot fire.
* [ ] Add a pickup that refills ammo or swaps a weapon.
* **Hint:** Where should the weapon state live—on the player component, or in a separate "inventory" class? How does the UI read this state?
* **Resource:** Flame docs: *Game Loop & State* (how to structure game data).

### **Project 6: “Bomb & Melee” (Different Attack Types)**

* **Objective:** Implement projectile and instant-hit attacks.
* **Tasks:**
* [ ] **Bomb:** Spawn a bomb component that arcs (simple physics) and creates an explosion (an area collision) after a timer.
* [ ] **Melee:** On button press, check for enemies within a short radius using `HasCollisionDetection` or a simple distance check.
* [ ] Both attacks consume separate "bomb" and "melee" counters.
* **Hint:** How can you use `TimerComponent` for the bomb fuse? For melee, is it easier to use a circle hitbox that is only active for a few frames?
* **Resource:** Flame docs: *Effects & Timers*.

### **Project 7: “Three Maps” (Tiled Integration)**

* **Objective:** Load and switch between levels.
* **Tasks:**
* [ ] Install `flame_tiled`. Create a simple map in the Tiled editor (platforms/obstacles).
* [ ] Load it with `TiledComponent.load()`.
* [ ] Use object layers from Tiled to define spawn points for players and pickups.
* [ ] Add a way to switch between 3 different `.tmx` files.
* **Hint:** How do you make the camera respect the map boundaries? What is a `Boundary` component?
* **Resource:** Flame docs: *Tiled*.

---

## Phase 3 — Multiplayer (The Hard Part)

### **Project 8: “LAN Echo” (UDP Basics)**

* **Objective:** Send and receive raw data between two instances on your machine.
* **Tasks:**
* [ ] Create a simple Flutter app (no game) that sends a UDP packet to `127.0.0.1` on a fixed port.
* [ ] Listen on that port and print the received message.
* [ ] Send a serialized object (e.g., a `Map` encoded as JSON bytes) instead of a string.
* **Hint:** What is the difference between `RawDatagramSocket.bind` and `connect`? Why must you listen for `RawSocketEvent.read`?
* **Resource:** Dart `RawDatagramSocket` API docs.

### **Project 9: “Two-Player Tag” (Host-Client Sync)**

* **Objective:** Sync one player's position to another device.
* **Tasks:**
* [ ] One instance is the **Host** (binds and listens). The other is the **Client** (sends its input to the host's IP).
* [ ] The host simulates both players. It sends back the authoritative positions 20 times per second.
* [ ] The client renders its own player *immediately* (for responsiveness) but renders the remote player using the received positions (with interpolation).
* **Hint:** Why does the client need to interpolate? What happens if you just snap to the received position? (Look up "snapshot interpolation").
* **Resource:** ENet Dart package (designed for Flame multiplayer). Also, the `mopong` GitHub repo shows a minimal 2-device UDP/ZeroConf example.

### **Project 10: “Hotspot Discovery” (Finding the Host)**

* **Objective:** Automatically find a host on a local network without typing IPs.
* **Tasks:**
* [ ] Host broadcasts a "beacon" UDP packet to `255.255.255.255` every second.
* [ ] Client listens on that port and shows a list of discovered hosts.
* [ ] Connect to the selected host.
* **Hint:** What are the Android/iOS permissions needed for local network access? (Android: `INTERNET`, `ACCESS_NETWORK_STATE`, `CHANGE_WIFI_MULTICAST_STATE`; iOS: `NSLocalNetworkUsageDescription`). Remember: neither OS lets you *enable* the hotspot programmatically.
* **Resource:** `nearby_connections` package (as a fallback that works over Bluetooth/Wi-Fi without a hotspot).

---

## Phase 4 — The Full Game

### **Project 11: “Mini Shooter Prototype” (Assembly)**

* **Objective:** Combine everything into a single loop.
* **Tasks:**
* [ ] Integrate the two-finger controls, weapons, bombs, melee, and inventory from Phase 2.
* [ ] Add the host-authoritative netcode from Phase 3.
* [ ] Use Tiled maps for the 3 arenas.
* [ ] Add a health bar (Flutter overlay widget listening to game state) and a lobby screen.
* **Hint:** Don't try to sync *everything* at 60Hz. Sync only **inputs** from clients to host, and **snapshots** (positions, health, ammo) from host to clients. Use a `FixedTimeStep` in the host's game loop for consistency.

---

## 📚 Master Resource List

* **Google Codelab:** *Introduction to Flame with Flutter* (Covers GameWidget, game loop, components, collisions, effects, and state management).
* **Official Flame Docs:** `docs.flame-engine.org` (Camera, Collision, Tiled, Effects).
* **Book:** *Flame Game Development* (A project-based book with examples like Meteor Shower and Jump Between Tiles—use it for inspiration, not copy-paste).
* **Multiplayer:** `enet` package, `mopong` repo, and the DEV article on real-time multiplayer with Flame.

**One final hint:** When you get stuck, don't look for a full solution. Instead, search for the *specific* API name (e.g., `camera.zoomTo`, `HasCollisionDetection`, `RawDatagramSocket`). The official docs and the Flame examples folder on GitHub are your best debugging companions.
