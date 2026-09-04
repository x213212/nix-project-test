# nix-project-test

A minimal, reproducible Nix project that demonstrates a shared library with two
consumers, plus a script that renders the actual dependency graph Nix builds.

The point is to make the dependency edges *visible*: `graphviz.py` walks the
derivations and emits `dependencies.dot` / `dependencies.png`, so you can see
that `appA` and `appB` genuinely share one `libdep` build rather than each
compiling their own copy.

## Layout

```
default.nix          top level - exposes libdep, appA, appB
libdep/              shared C library (libdep.c/.h + default.nix)
appA/                consumer A (main.c + default.nix)
appB/                consumer B (main.c + default.nix)
graphviz.py          renders the dependency graph
dependencies.dot     generated graph source
dependencies.png     generated graph image
```

`default.nix` wires them together with `callPackage`, so `libdep` is built once
and passed to both apps:

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  libdep = pkgs.callPackage ./libdep/default.nix { inherit (pkgs) lib; };
  appA   = pkgs.callPackage ./appA/default.nix   { inherit libdep; };
  appB   = pkgs.callPackage ./appB/default.nix   { inherit libdep; };
in
{
  inherit libdep appA appB;
}
```

## Build

```bash
nix-build -A appA
nix-build -A appB
nix-build            # everything
```

## Regenerate the dependency graph

```bash
python3 graphviz.py
```

Set `TARGET_DIR` at the top of `graphviz.py` to this checkout before running —
it defaults to an absolute path from the original machine.

Requires `graphviz` on PATH.

## License

MIT. See [LICENSE](LICENSE).
