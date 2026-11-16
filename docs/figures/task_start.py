"""How DD starts a service task: order NN/ → slot → SPECMON → TASKnn from 5/D73LIB."""

from svg import Figure, LARGE, BLUE, GREEN, YELLOW, ORANGE, GRAY, GREY, RED


def main():
    f = Figure(940, 400, LARGE)
    # Main path.
    f.box(20, 60, 140, 60, GRAY, "42515/", 11, mono=True, weight="bold")
    f.lines(90, 145, ["console order"], 9.5, fill=GREY)
    f.box(200, 60, 150, 60, BLUE, "STARTJOB", 11, weight="bold")
    f.lines(275, 145, ["finds a free", "slot Шnn"], 9.5, fill=GREY)
    f.box(390, 60, 150, 60, BLUE, "SPECMON", 11, weight="bold")
    f.lines(465, 145, ["name TASK15,", "reg. 1 = 425"], 9.5, fill=GREY)
    f.box(580, 60, 150, 60, YELLOW, "5/D73LIB", 11, weight="bold")
    f.lines(655, 145, ["loader reads", "the module"], 9.5, fill=GREY)
    f.box(770, 60, 150, 60, GREEN, "TASK15 runs", 11, weight="bold")
    f.lines(845, 145, ["as Ш23(S)"], 9.5, fill=GREY)
    for x in (160, 350, 540, 730):
        f.arrow(x, 90, x + 38, 90)
    # Failures.
    f.box(200, 250, 150, 50, ORANGE, "А Я ЗАНЯТА", 10.5)
    f.lines(275, 325, ["no free slot"], 9.5, fill=GREY)
    f.arrow(275, 190, 275, 248, stroke=RED)
    f.box(580, 250, 150, 50, ORANGE, "ТАSК!", 10.5)
    f.lines(655, 325, ["no such module"], 9.5, fill=GREY)
    f.arrow(655, 190, 655, 248, stroke=RED)
    f.write()


main()
