# Use bash with strict flags
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

# Column count for keymap-drawer parsing
COLS := "10"

# Output directory
OUT := "assets"

# Layers to draw (space-separated)
LAYERS := "base lower raise nav_3d"

# ---------- Phonies ----------
default: all

# End-to-end
all: draw

# 1) keymap.json -> keymap.yaml
parse:
    echo "Parsing JSON -> YAML (cols={{COLS}})"
    keymap parse -c {{COLS}} -z "config/kyria_rev3.keymap" > "{{OUT}}/keymap.yaml"

# 2) Draw each layer to its own SVG
draw: parse
    #!/usr/bin/env bash
    set -euo pipefail
    keymap draw "{{OUT}}/keymap.yaml" -o "{{OUT}}/keymap.svg";
    for L in {{LAYERS}}; do
        echo "Drawing layer: $L"
        keymap draw "{{OUT}}/keymap.yaml" -s "$L" -o "{{OUT}}/keymap_$L.svg";
        echo "SVG written to {{OUT}}/keymap_$L.svg"
    done

# Cleanup
clean:
    rm -rf "{{OUT}}"
