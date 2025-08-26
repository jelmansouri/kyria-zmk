# Use bash with strict flags
set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

LAYOUT_DRAWINGS_OUT := "assets/layout_drawings/generated"
LAYOUT_DRAWINGS_CONFIG := "assets/layout_drawings/keymap-config.yaml"

LAYER_NAMES := "base lower raise nav_3d"

default: all

all: draw

parse:
    keymap -c "{{LAYOUT_DRAWINGS_CONFIG}}" parse -c 10 -z "config/kyria_rev3.keymap" > "{{LAYOUT_DRAWINGS_OUT}}/keymap.yaml"

draw: parse
    #!/usr/bin/env bash
    set -euo pipefail
    keymap draw "{{LAYOUT_DRAWINGS_OUT}}/keymap.yaml" -o "{{LAYOUT_DRAWINGS_OUT}}/keymap.svg";
    for L in {{LAYER_NAMES}}; do
        echo "Drawing layer: $L"
        keymap draw "{{LAYOUT_DRAWINGS_OUT}}/keymap.yaml" -s "$L" -o "{{LAYOUT_DRAWINGS_OUT}}/keymap_$L.svg";
        echo "SVG written to {{LAYOUT_DRAWINGS_OUT}}/keymap_$L.svg"
    done

# Cleanup
clean:
    rm {{LAYOUT_DRAWINGS_OUT}}/*
