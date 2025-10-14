# Fast-updating apps policy

This repository keeps fast-moving apps (like Cursor) pinned declaratively, but provides an easy switch to update them quickly without touching the rest of the system.

How it works
- Each fast app gets its own module under modules/fast-apps/<app>.nix
- Version and hash live in one place at the top of the module
- A helper script `update-fast-app` automates bumping version/hash

Usage
- Update a single app:
  update-fast-app cursor 0.49.1
  # The script prefetches the new URL, updates the hash, commits the change

- Apply changes:
  sudo nixos-rebuild switch --flake .#yukishidzu

Notes
- The helper does not change nixpkgs; only the targeted app is updated
- All updates remain declarative (version+hash are stored in git)
