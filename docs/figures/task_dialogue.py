"""Operator–task dialogue: short answers through cell 101B (Э66), lines through Э205."""

from svg import Figure, LARGE, BLUE, GREEN, YELLOW, GRAY, GREY


def main():
    f = Figure(940, 420, LARGE)
    f.box(20, 40, 180, 340, GRAY, None)
    f.text(110, 75, "console", 11, weight="bold")
    f.box(380, 40, 180, 340, BLUE, None)
    f.text(470, 75, "DD", 11, weight="bold")
    f.box(740, 40, 180, 340, GREEN, None)
    f.text(830, 75, "task Ш23(S)", 11, weight="bold")
    # Question.
    f.arrow(740, 125, 202, 125)
    f.text(470, 115, "Ш23(S)-ПРОСМОТР МОЗУ-", 9.5, mono=True)
    f.text(470, 145, "Э76: text to the console", 9, fill=GREY)
    # Short answer.
    f.arrow(200, 205, 378, 205)
    f.text(290, 195, "1000SN", 9.5, mono=True)
    f.box(400, 180, 140, 50, YELLOW, "cell 101B", 10)
    f.arrow(560, 205, 738, 205)
    f.text(650, 195, "1000", 9.5, mono=True)
    f.text(650, 230, "Э66 returns it", 9, fill=GREY)
    # Whole line.
    f.arrow(200, 305, 378, 305)
    f.text(290, 295, "S=text", 9.5, mono=True)
    f.box(400, 280, 140, 50, YELLOW, "telegram", 10)
    f.arrow(560, 305, 738, 305)
    f.text(650, 295, "text", 9.5, mono=True)
    f.text(650, 330, "Э205 returns it", 9, fill=GREY)
    f.write()


main()
