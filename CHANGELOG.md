## 1.3.0

* split the `installPhase` by extracting the `unpackPhase`

## 1.1.0

* Get rid of nodegit, not being used anymore by clever-tools.
* Fix harcoded binary offsets used by `zeit/pkg` (which bundle the executable).

## 0.9.3

* Use patchelf to make the binaries nix-compliant.
* Introduce custom `nodegit` derivation.
