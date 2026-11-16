# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

An archive of OS Dubna for the BESM-6 mainframe (sources saved circa 1988) plus the
scripts by M. Popov (2017-2019) that rebuild it and boot it on the SIMH `besm6` simulator.
There is no conventional build system or test suite: "building" means running BESM-6 batch
jobs under the `dubna` simulator to compile the sources, then assembling disk/drum images
with `dd` and booting them in SIMH.

Terminology used everywhere:

- **DD** — Dubna Dispatcher (the OS kernel), sources in Madlen assembler.
- **MS** — Monitor System "Dubna" (monitor + dynamic loader + libraries), sources in Fortran/Madlen.
- **STL** — static library; **LD** — loader; **Multitype** — the terminal subsystem.
- **dubna** — a fast simulator that runs Monitor Dubna batch jobs (`.dub` files), with its
  extracodes done in C++; the cross-build host (source at github.com/besm6/dubna). Until 2026
  the build used `dispak`, which runs a different BESM-6 OS (Диспак) with its own monitor.
- **perso** — compiled object zones on a tape; **cosy** — the compressed source text format.

## Layout

- `besmdisp/`, `besmmons/`, `besmtask/`, `besml21/`, `besml23/` — the source texts fed to the build
  (DD, MS, Madlen/loader/system tasks, library 21, library 23). Large files are split into sections.
- `dub_besm/` — the same DD and MS texts as single files, for reference only.
- `monsys/`, `lib12/`, `lib37/` — original binary tape images (9/MONSYS, 12/LIBRAR, 37/LIBRAR).
  The libraries and the compilers inside 9/MONSYS are used as binaries; the rest of MS is
  rebuilt from `besmmons/`.
- `drums/` — drum images with hardware tests; `d_besm6/` — miscellaneous old files, not used by the build.
- `tapes/1200`, `jobs/monsys.b6` — MS sources as a tape image and the job that compiles them.
- `BUILD/` — everything needed for the bootstrap (see below).
- `BUILD/elements/MonitorDubna.txt` — a description of Monitor Dubna, written in Russian. This is
  where nearly all recent commits go.
- `file-list.md` — annotated list of the archive files.
- `docs/` — reference articles in English; read the relevant one before working on that topic:
  - `Madlen.md` — Madlen assembler syntax, declarations, control cards, error diagnostics.
  - `Besm6_Instruction_Set.md` — registers, instruction formats, every opcode.
  - `Besm6_Data_Representation.md` — 48-bit word layout, integers, floating point, characters.
  - `Memory_Mapping.md` — page registers, protection, supervisor mode, the БРЗ cache.
  - `Peripherals.md` — device registers, control words and interrupt bits (drums, disks,
    tapes, printer, terminals) as seen by a driver.
  - `Simh_Simulator.md` — building and operating SIMH `besm6`: `attach`/`set` commands,
    loading, front panel, debugging and tracing.
  - `KOI7_Encoding.md` — the KOI-7 code page used by BESM-6 text and the line printer.
  - `Switch_Registers.md` — meaning of each bit of switch registers ТР1–ТР7 in DD, panel
    commands, and the values used by the `BUILD` boot scripts.
  - `Dubna_Commands.md` — operator console orders (tty25), print spooler orders, Multitype
    commands (tty26) and the replies to them.
  - `Boot_Process.md` — how the bootstrap works: dubna stage, disk and drum images, the SIMH
    boot sequence, the rebuild jobs, running and pitfalls.
  - `OS_Dubna_Tutorial.md` — for users: start the system, log in to Multitype, type and run
    a job, read the printout.
  - `Formatting_Tapes.md` — for users: format a blank magnetic tape with task 62 (orders
    `МР`, `ИМР`), the console dialogue, errors, what is written on the tape.
  - `Monsys9_Tape.md` — layout of the system tape 9/MONSYS (MS zones, catalogs, static
    sections, libraries), how the MS is rebuilt from sources and what stays binary.
  - `Service_Tasks.md` — the service tasks 11–76 of 5/D73LIB: how DD starts them (`NN/`),
    the dialogue, and what each task does. Figures are SVG made by `docs/figures/*.py`
    (`make` there; `svg.py` is the helper).

  The articles, except `Switch_Registers.md`, `Dubna_Commands.md`, `Boot_Process.md`,
  `OS_Dubna_Tutorial.md`, `Formatting_Tapes.md`, `Monsys9_Tape.md` and `Service_Tasks.md` (written here), are copies from other BESM-6
  projects (besm6/simh, v7besm, c-compiler); a note under each title names the origin. Their "kernel" and "compiler" are those projects', and
  links to files outside `docs/` are absolute GitHub URLs. Keep it that way when adding more:
  no relative links to files that are not in this repo.

## Bootstrap

Run from `BUILD/`; scripts use relative paths and must be started in their own directory:

```sh
cd BUILD && ./bootstrap.sh
```

Requirements: `dubna` and `besmtool` on PATH, SIMH `besm6` on PATH built from branch
`master` of simh-besm6 (`set cpu mem=128`, `set cpu ext32`), Python 3. `dubna` must be recent
enough to grow tape images on write, tag the words it writes and do sector exchanges with
disks (November 2026).

The scripts read and write tape images in `BUILD/tapes/` (ignored by git), named by tape
number. `BUILD/env.sh`, sourced by every script, sets `TAPES` and exports `BESM6_PATH` so
that `dubna` and `besmtool` look there first and then in `/usr/local/share/besm6`.

Pipeline in `bootstrap.sh`:

1. `populate-dsk.sh` — write the original tape images into `BUILD/tapes`.
2. `mk-dd-src.sh`, `mk-ms-src.sh`, `mk-stl-src.sh`, `mk-ld-src.sh` — each one runs a dubna
   job through `run_src_job` (`env.sh`): the sources, concatenated, are mounted as a local
   file on unit 50, copied by the editor to the target tape from zone 100 and compiled to
   zones 0-77. `mk-lib21-src.sh`, `mk-lib23-src.sh`, `mk-exfor-src.sh` follow the same
   pattern but are not called by the bootstrap.
   `mk-ms-img.sh` then assembles the MS: `COLLECT` and `COMTODRU` (library 21) link the
   perso of tape 200 into a copy of drums 21, 22, and `ms-splice.py` puts it into a copy of
   9/MONSYS (tape 203, `data/mons9.bin`), keeping the old static sections of the compilers,
   which have no perso. `ms-check.sh` compares tape 200 with the archived library: only
   `CHKBEG*` and `EDIT***` differ in size.
3. `data/mkdisk9.sh`, `data/mkdisk11.sh`, `data/mkbridges.sh` — concatenate catalog + contents
   + padding into SIMH disk images and symlink them into `BUILD/tapes` as bridge tapes.
4. `deck-b1/mk-deck-b1.sh` — emit the patch deck job (config + fixes for SIMH), then run
   `debmult.dub` and the deck under `dubna` to link DD onto tape 999.
5. `data/mkdrumdd.sh` — cut drum images out of tape 999.
6. `tra-libs.dub` — copy libraries and rebuild jobs onto disk for use inside SIMH.
7. `mk-base.sh` — rebuild the images, then boot SIMH twice with `boot-run.py deck` (the job is a
   deck of punch cards in reader `vu0`, started by console order `01В`; `boot-run.py` drives
   the consoles over sockets by send/expect, `boot-run.ini`): job `newbsz` builds the task library
   5/D73LIB (the print spooler is in it), job `newdd` writes a rebuilt DD to drum 25. The
   images are saved in `BUILD/data/base/`, which is tracked in git (about 4 MB per version
   in history), so users can run the system without building it. Commit new images only
   when the system changes. A last `boot-run.py` run checks Multitype with hello.

After the bootstrap, run the system with `besm6 dubna.ini` from `BUILD/` (console on the
terminal, Multitype on telnet port 4199). `./boot-run.py deck` boots and runs a deck of punch cards
non-interactively, `./boot-run.py -m zone` a job from 7/M through Multitype; run it without
arguments for the options (`-f` restores `data/base`, `-d 25` boots the rebuilt DD, `-e 0`
makes printer 0 an ЕС-7032/7033 with ТР7 bit 34, `-q`
queues a Multitype job with `ПУС` so its listing is printed). `./card-run.sh job.dub` runs a job from a deck of punch
cards instead: a demo in plain SIMH script (`card-run.ini`, `go until`/`send` on the console,
console order `01В`). `./tape-format.sh` is a demo of the same kind for magnetic tapes: it attaches a blank
reel as `mg60` and has task 62 format and name it (order `ИМР`, see `docs/Dubna_Commands.md`). Transcripts: `boot-run-tty25.txt`, `boot-run-tty26.txt`,
printer: `output.txt`. `runtests.ini` runs the hardware tests from the drum images.

Each job's listing lands in `BUILD/*.list`; errors are found by reading these, not from
exit codes (`БЫЛИ OШИБKИ`, `Error:`). `deck-b1/deck.notes` lists known restrictions, e.g.
the date accepts only year 1989.

## Tape numbers

Tape numbers are hardcoded across the scripts and job files; `BUILD/ReadMeTapes.txt` is the
authoritative map. Each build tape holds perso (compiled objects) in zones 00-77 and
cosy sources from zone 100. dubna takes tape numbers up to 999, so the 2017 numbers lost
their thousands digit (1400 → 400).

| Range | Use |
| --- | --- |
| 9, 12, 37 | original images: monsys, librar-12, librar-37 |
| 100-199 | compilers (100 loader) |
| 200-399 | MS and libraries (200 MS, 201 COLLECT output, 202 MS drums, 203 9/MONSYS with the rebuilt MS, 221 lib21, 223 lib23, 247 tasks, 301 exfor) |
| 400-899 | DD (400) |
| 900-999 | scratch (922 tape 203 from zone 40: MS drum 22, 990 DD perso, 999 linked DD with the system) |
| 209, 211, 224 | bridge tapes dubna/SIMH: symlinks to disks 9, 11, 24 |

## Job files and sources

- `*.dub` files and the heredocs in `mk-*.sh` are Monitor Dubna batch jobs for `dubna`:
  control cards starting with `*`, from `*name` to `*end file`. `*tape:999/dd,67,w` mounts
  tape 999 as unit 67 with write permission; `*to perso:66000,77` addresses unit 66, zone 000.
  Run them with `run_job` (`env.sh`), which turns tabs into spaces. Monitor Dubna's Madlen
  rejects empty lines, and `*no list` makes the cards after it fail. The `.b6` files left
  (`pult9*.b6`, `boot_dubna*.b6`, `jobs/monsys.b6`) are SIMH panel files or old Dispak jobs.
- All texts are UTF-8, but BESM-6 text mixes Latin and Cyrillic lookalike letters within
  one word (e.g. `SТЕХТ=FRЕQ300` contains Cyrillic `Т`, `Е`, `Х`). Keep the existing bytes when
  editing, and search with that in mind — a plain ASCII grep can miss identifiers.
- Madlen source lines have the form ` label:register,OPCODE,operand.comment`; `C` in
  column 1 starts a comment line (`Cs` marks the 2017 SIMH changes). See `docs/Madlen.md`.
- `deck-b1/*.s` hold the changes to DD needed for SIMH, as whole patched Madlen modules
  compiled by the patch deck (`deck-b1/mk-deck-b1.sh`). Change the system there, not in the
  archived sources.
- Simulator requirements found so far: `set cpu mem=128`, `set cpu ext32`, the card
  reader fixes, tape formatting on `mg6`, the ЕС printer mode `set prnN es` with
  ДРП/ДРМ (all on branch `master` of simh-besm6). Simulator changes go to that branch; OS changes to `deck-b1/`.

## Cosy tools

`BUILD/cosy/` has small Go converters between the cosy format, UTF-8 and ISO:

```sh
cd BUILD/cosy
make        # builds cosy2utf, utf2cosy, utf2iso and runs go fmt
make test   # go run cosytest.go cosy2iso.go
```
