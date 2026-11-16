# Copyright (c) 2026 Serge Vakulenko
# SPDX-License-Identifier: MIT

"""Minimal SVG writer for the figures in docs/.

A figure script makes a Figure, draws on it and calls write(), which prints
the SVG: python3 pdf_file.py > pdf_file.svg (see docs/figures/Makefile). Units are
pixels, origin top left. Plain SVG only, so GitHub, browsers and pandoc
render it the same.
"""

import math
import sys
from xml.sax.saxutils import escape

# Figures print at about 0.55 of their pixel size (17 cm text width); text
# sizes in the scripts are multiplied by this so they print near 8.5 pt.
SCALE = 1.3
# Larger text, for figures that print small; the layout must leave room.
LARGE = 1.7

SANS = "Helvetica, Arial, sans-serif"
MONO = "DejaVu Sans Mono, Menlo, Consolas, monospace"

INK = "#333333"
GREY = "#808080"
LIGHT = "#f2f2f2"
RED = "#d62728"

# Fill and line colour pairs.
BLUE = ("#dae8fc", "#6c8ebf")
GREEN = ("#d5e8d4", "#82b366")
YELLOW = ("#fff2cc", "#d6b656")
PURPLE = ("#e1d5e7", "#9673a6")
ORANGE = ("#ffe6cc", "#d79b00")
GRAY = ("#f5f5f5", "#999999")


def fmt(v):
    s = f"{v:.2f}".rstrip("0").rstrip(".")
    return "0" if s in ("-0", "") else s


class Figure:
    def __init__(self, width, height, scale=SCALE):
        """scale multiplies every text size; see SCALE."""
        self.w, self.h = width, height
        self.scale = scale
        self.items = []

    def _add(self, s):
        self.items.append(s)

    def rect(self, x, y, w, h, fill="none", stroke=INK, width=1, dash=None, rx=0):
        extra = f' stroke-dasharray="{dash}"' if dash else ""
        extra += f' rx="{fmt(rx)}"' if rx else ""
        self._add(f'<rect x="{fmt(x)}" y="{fmt(y)}" width="{fmt(w)}" height="{fmt(h)}" '
                  f'fill="{fill}" stroke="{stroke}" stroke-width="{fmt(width)}"{extra}/>')

    def box(self, x, y, w, h, colour, label=None, size=13, mono=False, weight="normal"):
        """A filled box from a colour pair, with an optional centred label."""
        self.rect(x, y, w, h, fill=colour[0], stroke=colour[1], width=1.2, rx=3)
        if label is not None:
            lines = label.split("\n")
            k = size * self.scale
            y0 = y + h / 2 - (len(lines) - 1) * k * 0.6 + k * 0.35
            for i, s in enumerate(lines):
                self.text(x + w / 2, y0 + i * k * 1.2, s, size, mono=mono, weight=weight)

    def line(self, x1, y1, x2, y2, stroke=INK, width=1, dash=None):
        extra = f' stroke-dasharray="{dash}"' if dash else ""
        self._add(f'<line x1="{fmt(x1)}" y1="{fmt(y1)}" x2="{fmt(x2)}" y2="{fmt(y2)}" '
                  f'stroke="{stroke}" stroke-width="{fmt(width)}"{extra}/>')

    def polygon(self, pts, fill, stroke="none", width=1):
        p = " ".join(f"{fmt(x)},{fmt(y)}" for x, y in pts)
        self._add(f'<polygon points="{p}" fill="{fill}" stroke="{stroke}" stroke-width="{fmt(width)}"/>')

    def path(self, d, stroke=INK, width=1, fill="none", dash=None):
        extra = f' stroke-dasharray="{dash}"' if dash else ""
        self._add(f'<path d="{d}" fill="{fill}" stroke="{stroke}" stroke-width="{fmt(width)}"{extra}/>')

    def text(self, x, y, s, size=13, fill=INK, anchor="middle", weight="normal", mono=False, italic=False):
        """Text with its baseline at y; size is multiplied by the figure scale."""
        size *= self.scale
        extra = f' font-weight="{weight}"' if weight != "normal" else ""
        extra += ' font-style="italic"' if italic else ""
        self._add(f'<text x="{fmt(x)}" y="{fmt(y)}" font-family="{MONO if mono else SANS}" '
                  f'font-size="{fmt(size)}" fill="{fill}" text-anchor="{anchor}"{extra}>{escape(s)}</text>')

    def lines(self, x, y, strings, size=13, fill=INK, anchor="middle", mono=False, spacing=1.25):
        for i, s in enumerate(strings):
            self.text(x, y + i * size * self.scale * spacing, s, size, fill, anchor, mono=mono)

    def head(self, x, y, angle, colour, size=7):
        a, b = angle + math.pi - 0.4, angle + math.pi + 0.4
        self.polygon([(x, y), (x + size * math.cos(a), y + size * math.sin(a)),
                      (x + size * math.cos(b), y + size * math.sin(b))], fill=colour)

    def arrow(self, x1, y1, x2, y2, stroke=INK, width=1.2, dash=None, both=False):
        """A straight arrow with its tip at (x2, y2)."""
        ang = math.atan2(y2 - y1, x2 - x1)
        k = 5.5
        sx, sy = (x1 + k * math.cos(ang), y1 + k * math.sin(ang)) if both else (x1, y1)
        self.line(sx, sy, x2 - k * math.cos(ang), y2 - k * math.sin(ang), stroke, width, dash)
        self.head(x2, y2, ang, stroke)
        if both:
            self.head(x1, y1, ang + math.pi, stroke)

    def curve(self, x1, y1, cx1, cy1, cx2, cy2, x2, y2, stroke=INK, width=1.2, dash=None):
        """A cubic Bezier arrow ending at (x2, y2)."""
        self.path(f"M{fmt(x1)},{fmt(y1)} C{fmt(cx1)},{fmt(cy1)} {fmt(cx2)},{fmt(cy2)} {fmt(x2)},{fmt(y2)}",
                  stroke, width, dash=dash)
        self.head(x2, y2, math.atan2(y2 - cy2, x2 - cx2), stroke)

    def write(self):
        out = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{fmt(self.w)}" height="{fmt(self.h)}" '
               f'viewBox="0 0 {fmt(self.w)} {fmt(self.h)}">',
               f'<rect width="{fmt(self.w)}" height="{fmt(self.h)}" fill="white"/>']
        sys.stdout.write("\n".join(out + self.items + ["</svg>"]) + "\n")
