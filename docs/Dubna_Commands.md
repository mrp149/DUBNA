# Operator and Multitype Commands in OS Dubna

> Written for this repository from the Dubna Dispatcher (DD) sources in [besmdisp/](../besmdisp)
> and the spooler in [besmtask/](../besmtask). Line links point into those files.

OS Dubna talks to people through Consul typewriters. In the SIMH setup there are two:

| Line | Who listens | Used for |
| --- | --- | --- |
| tty25 | DD order analyser `TTANAL` ([macro67.dd1:5906](../besmdisp/macro67.dd1#L5906)) | Operator console: date, time, printers, tapes, the planner. |
| tty26 | Multitype `MULTITYP` ([nrespost.dd3:9356](../besmdisp/nrespost.dd3#L9356)) | User terminal: log in, edit a deck, start jobs, watch them. |

A free line chooses its role by what is typed first: `ОР` binds it as an operator console
(reply `!!!`; the 2017 script `expe.ex` did this on tty26), two spaces bind it to Multitype. `REF` gives an
operator console back.

## Common rules

- **A line ends with CR.** The Consul input register holds one character, so scripts send one
  character at a time (`boot-run.py` waits 20 ms between them).
- **Lookalike letters.** BESM-6 text mixes Latin and Cyrillic letters that look the same
  (А В Е К М Н О Р С Т Х У). The system treats them as one letter: `KAK` typed in Latin is
  the command `КАК`. Its echo is usually Cyrillic: `A1P` comes back as `А1Р`, `PASS` as `РАSS`.
  Letters without a lookalike must be typed as written: `Л`, `Ш`, `Ы`, `Д` in Cyrillic, `D`,
  `F`, `I`, `N`, `R`, `S`, `U` in Latin.
- **Numbers are octal.** Task, tape and zone numbers, addresses, all of them.
- **Шифр.** A job runs on a *шифр* (accounting channel) Ш01–Ш20. Its messages on the console
  start with it: `01Ш05:НЕLLО` is job НЕLLО, input file entry 01, running on Ш05. Classes:
  Ш01–Ш04 batch from the input device, Ш05–Ш07 linked and non-dialogue terminal jobs,
  Ш10–Ш20 dialogue jobs ([macro67.dd1:31](../besmdisp/macro67.dd1#L31)).
- **Task.** A *task* is a numbered slot in DD (octal). Service tasks have fixed numbers:
  10 planner, 11 output (ВЫВОД), 61 DAY-FILE, 62 disk formatting, 70 link, 74 batch input,
  75 operator service ([macro67.dd1:5929](../besmdisp/macro67.dd1#L5929)).

## A typical session

Operator console (tty25), from `BUILD/boot-run-tty25.txt`. `>` marks what is typed.

```
ОИЯИ. ОС ДУБНА ОТ 11.11.26 М1        banner: DD version and its build date
МОNSУS/9 W10 ... САТАLО/8 W23        tapes modelled on disk/drum (ТР1 bit 24)
>                                    empty line wakes the console
!!!
>040489D                             set the date: 04.04.89
04/04/89 Т=00.00.03
>T                                   dispatcher and idle times
Д00.00.04 Ж00.00.04
Д-2000  МС-Ф10,                      DD and Monitor System are ready
ВЫВОД БУФЕРИЗОВАН                    the output task runs
УСТАНОВИТЕ ЛИСТ НА АЦПУ-1, ЗАТЕМ ДАЙТЕ ПРИКАЗ  А1Р
ПЛАНИРОВЩИК                          the planner runs: jobs can start
>A1P                                 paper is in, printer 1 goes automatic
01Ш05:НЕLLО                          a job from the input file starts on Ш05
```

Multitype (tty26), from `BUILD/boot-run-tty26.txt`:

```
>␣␣                                  two spaces bind the line to Multitype
МУЛЬТИТАЙП  (ВЕРСИЯ ОТ 15/12/87)   ЭВМ-0
     РАSS:*****                      >MJPOP, echo masked
     БУФЕР:*/*                       >7/M: the buffer is tape 7/M
>ЛИС 110                             list the deck at zone 110
*NАМЕ НЕLLО
...
*ЕND FILЕ
>ПУС 110,17                          put it into the input file
     ЖДИТЕ ОТВЕТА
ПАКЕТ В ФАЙЛЕ ВВОДА: 01
>КАК                                 how are my jobs?
     НЕТ ЗАДАЧ
```

## Operator console orders

`TTANAL` reads the whole line, then:

1. **Special lines** are recognised by their start ([macro67.dd1:6069](../besmdisp/macro67.dd1#L6069)):
   empty line, `ТЕЛ…`, `МТ-…`, `ЭР-…`, `СВ-…`, and lines whose second character is `=` or `-`.
2. Otherwise every digit of the line is packed in octal into one number, `NN` below
   ([macro67.dd1:6127](../besmdisp/macro67.dd1#L6127)), and the last 8 characters are kept.
3. **The last character picks the order** from table `TABCOM`
   ([macro67.dd1:7504](../besmdisp/macro67.dd1#L7504)): `: В . С П Т Л / I Н О + N А У Р D F Б`.
   The handler then looks at the characters before it.
4. Every order is written to the DAY-FILE unless ТР7 bit 32 is set.

### Special lines

| Order | Meaning |
| --- | --- |
| (empty) | Reply `!!!`. Used to check that the console is alive. |
| `ТЕЛ text` | Telegram to the link task ([6599](../besmdisp/macro67.dd1#L6599)). |
| `МТ-text` | Telegram to all Multitype terminals. |
| `ЭР-text` | Telegram to the screen editor users. |
| `СВ-text` | Telegram to the link task, Leningrad variant. |
| `x=text`, `x-text` | Pass the line to the terminal task chosen by `x` ([6223](../besmdisp/macro67.dd1#L6223)). |

### Date and time

| Order | Meaning |
| --- | --- |
| `D` | Print the date and clock: `04/04/89 Т=00.00.33`. Before a date is set: `00/00/00`. |
| `ДДММГГD` | Set the date, e.g. `040489D`. The year must be 89: the check is hard-coded ("В 1989 ГОДУ СЛЕД. КОМАНДУ ЗАМЕНИТЬ !!!", [7216](../besmdisp/macro67.dd1#L7216)). Prints the date as `D` does. |
| `DD` | Print the DD version text ("ОС ДУБНА ОТ …"). |
| `Т` | Times used by the dispatcher (`Д`) and by the idle task ЖДУ (`Ж`), hh.mm.ss. |
| `АТ` | Date and clock, as `D`. |
| `ЧЧ.ММТ` | Set the clock, e.g. `09.30Т`. |
| `NNТ` | Processor time of the job on Ш`NN`. |

### Jobs and the planner

| Order | Meaning |
| --- | --- |
| `NNВ` | Start a job on Ш`NN` straight from the card reader: `01В`. Reply `ШNN:NAME`. |
| `NNВСВ` | The same, input "with passport" (like ТР1 bit 48). |
| `ПВ` | Start batch input (task 74, `Ш23(S)-ПАКЕТНЫЙ ВВОД`): every deck in the reader goes into the input file, reply `Вnn(mm)-NAME` for each; the planner runs them later. |
| `Н` | Start the planner (task 10) and allow all шифры. The planner starts by itself at boot. |
| `NNН` | Allow the planner to use Ш`NN`. |
| `SН` | Forbid all шифры. |
| `NNSН` | Forbid Ш`NN`. |
| `NNБП` | Start input-file job `NN` out of turn on any free allowed шифр. |
| `NNПП` | The same, but only on Ш04–Ш01. |
| `NNФП` | The same, on Ш01 if it is free (background priority). |
| `УБП`, `УПП`, `УФП` | Cancel such a request (as read from the code, [7097](../besmdisp/macro67.dd1#L7097)). |
| `NN.` | Kill the task on Ш`NN`. Refused for special tasks and the link task. |
| `NNП` | Give Ш`NN` the top processor priority. |
| `NNС` | Times of the job on Ш`NN`: `К` command time, `С` run time, `Л` limit. |
| `valueШNN:` | Write `value` into the console word (ПУЛЬТ, cell 113) of the job on Ш`NN`. |

### Service tasks and output

| Order | Meaning |
| --- | --- |
| `NN/` | Start service task `NN`. `13/` is a known one; it replies `А Я ЗАНЯТА` if no slot is free. Each task is described in [Service_Tasks.md](Service_Tasks.md). |
| `text/` | Pass `text` to the operator service task 75 ([7000](../besmdisp/macro67.dd1#L7000)). |
| `Р` | Start the output task ВЫВОД (task 11), which drives the printers. It starts by itself at boot unless ТР2 bit 42 is set. |
| `NNР` | Start ВЫВОД with parameter `NN`. |
| `…nР` | An order for the running spooler, see [Print spooler orders](#print-spooler-orders). |
| `МР`, `ИМР`, `NИМР` | Format a magnetic tape (РАЗМЕТКА, task 62), see [Formatting a tape](#formatting-a-tape). |
| `textLN` | Answer a question of a service task: `L` is the letter the task shows after its шифр, e.g. `Ш23(S)` takes `60SN`. |
| `NNА` | Buffer the printed output of Ш`NN` (via the output file). |
| `NNУ` | Print the output of Ш`NN` directly on the printer, unbuffered. |
| `DF` | Print the DAY-FILE (task 61). |
| `I` | Start the link task 70 if it is not running. |
| `OSTA`, `CSTA` | Open / close the statistics file. |

### Tapes and disks

`NN` is the drive (tape) or module (disk) number.

| Order | Meaning |
| --- | --- |
| `NNКО` | Tape: stop the current exchange ("конец обмена"). |
| `NNРО`, `NNНО` | Tape: allow / skip recognition of the reel label. |
| `NNДКО` | Disk: stop exchanges with the module so it can be removed. Same as panel command 7. |
| `NNДРО`, `NNДНО` | Disk: allow / skip label recognition. Refused while the disk is in use. |
| `NNПЕР`, then `НАNNПЕР` | Move a reel to another drive. First reply `ДЕРЗАЙ` (go ahead), then `O'KEY`. |
| `NNМddddБ` | Give number `dddd` to the unlabelled tape on drive `NN`. Replies `O'KEY` or `УЖЕ ЕСТЬ 'name'!`. |
| `ПЛ`, `КПЛ` | Paper tape: start reading / mark end of tape. `НЕТ !` if there is no reader. |

### Formatting a tape

A new reel must be formatted before the system takes it: task 62
([task47.ts2:10871](../besmtask/task47.ts2#L10871)) erases the start of the tape and writes
the zones, each with 8 service words that hold the name of the tape, the reel number and the
zone number. `МР` only formats (a scratch tape without a name), `ИМР` also names the tape,
`NИМР` gives it standard name `N` (1 `D73INP`, 2 `D73ЗАД`, 3 `D73OUT`, 4 `D68LIB`,
5 `D73LIB`, 6 `D73STA`, 7 `ЦЫПЦЫП`).

Only the drives of direction 6 (60–67) can format. Switch register ТР3 must hold the drive
number in bits 48–43, otherwise the reply is `РАЗМЕТКА ЗАПРЕЩЕНА !`.

```
НЕ ОПОЗН.МЛ-60                      a blank reel is on drive 60
ИМР
Ш23(S)-Б6 РАЗМЕТКА                  S is the letter for the answers
МФ !
60SN                                the drive
ЧИСЛО ЗОН !
10SN                                the number of zones, octal
ИМЯ !
DEMOSN                              the name, up to 6 characters
N БОБ!
1234SN                              the reel number
DЕМО  /1234 (0010) МФ-60-ТАК ?
SN                                  yes; any text before SN starts over
РАЗМЕЧЕНО 0010 ЗОН.
```

The task waits about 15 seconds before it starts, then writes two blocks per zone and 8
more, about 0.3 s each. [tape-format.sh](../BUILD/tape-format.sh) does all this in SIMH;
[Formatting_Tapes.md](Formatting_Tapes.md) is the full manual.

### Consoles and terminals

| Order | Meaning |
| --- | --- |
| `REF` | Give up the console. Refused on the main console. |
| `PANNO` | Make this (non-main) console a display panel. |
| `NNDOWN`, `NNUP` | Block / unblock terminal `NN`. |
| `ALLDOWN`, `ALLUP` | Block / unblock all terminals. |
| `MTSTOP`, `SCSTOP`, `PTSTOP`, `LINKSTOP` | Stop Multitype, the screen editor, the paper-tape task, the link task. |

### Memory

| Order | Meaning |
| --- | --- |
| `addr:` | Print the memory word at octal `addr`. |

The front panel has its own commands (ТР6 bits 3–1 and the request button), see
[Switch_Registers.md](Switch_Registers.md#panel-commands).

## Print spooler orders

The output task ВЫВОД (task 47 code, `TELL` at [task47.ts2:1067](../besmtask/task47.ts2#L1067))
takes orders of the form `<key>nР` from the console. `n` is the printer: 1 or 2 (АЦПУ-1,
АЦПУ-2), 0 for any spooler. The manual is the comment at
[macro67.dd1:88](../besmdisp/macro67.dd1#L88).

When the spooler takes a printer it asks for paper and waits ("ЖДУ" in its task name):
`УСТАНОВИТЕ ЛИСТ НА АЦПУ-1, ЗАТЕМ ДАЙТЕ ПРИКАЗ А1Р`. In waiting mode it prints only express
orders. `А1Р` lets it print everything.

| Order | Meaning |
| --- | --- |
| `АnР` | Automatic mode: print all listings. |
| `ЖnР` | Waiting mode: print only express orders. |
| `СnР` | Paper was set at the fold line: reset the line count. |
| `ОnР` | Feed paper to the tear-off position. Refused before anything was printed (`СПЕРВА НАПЕЧАТАЙ, А ПОТОМ БУМАГУ ПРОГОНЯЙ!`) and while printing (`НЕ СУЕТИСЬ!`). |
| `КnР` | Remove the output task after the current listing. |
| `nР` | Skip the current listing (its last page is printed). Also the answer to "take the punched cards" (`ПФ-…`). Reply `ПРОП-NN`. |
| `ФnР` | Punched cards taken. |
| `CCCNNЭnР` | Express: print listing `NN` of the output file again, from page `CCC` (may be omitted), with its punched cards. Reply `ЭКСПР-`. |
| `CCCNNЛnР` | The same, listing only. |
| `NNПnР` | Punch the cards of `NN` again. |
| `ЛnР` | Listings only: punching is dropped. |
| `ПnР` | Punching only. |
| `ВnР` | Toggle between printing all laboratories (`ВСЕ ЛАБОР,`) and only ЛВТА (`ВЫВОД ЛВТА`). |
| `CCCNNДnР` | Double-sided printing of `NN` from page `CCC`. |
| `NNРnР` | Print `NN` beyond the paper limit. |

After a paper jam the manual says: `Ж1Р`, wait for the current listing to end, `С1Р`, set the
paper at the black line, `А1Р`.

## Console replies

| Reply | Meaning |
| --- | --- |
| `!!!` | Order not understood (or an empty line). |
| `НЕТ !` | No such thing. |
| `НЕЛЬЗЯ` | Not allowed now. |
| `ДЕРЗАЙ` | Go ahead (first step of a two-step order). |
| `O'KEY` | Done. |
| `ГТ-NN` | Tape `NN` is not ready. |
| `ЗП-NN` | Tape `NN` has no write ring. |
| `УЖЕ ЕСТЬ 'name'!` | A tape with that name is already mounted. |
| `А Я ЗАНЯТА` | No free slot: the task was not started. |
| `ОШ.ПРИКАЗ` | Bad spooler order. |
| `НЕТ АЦПУ ДЛЯ ВЫВОДА!` | The spooler found no free printer. |

Messages that appear on their own:

| Message | Meaning |
| --- | --- |
| `ОИЯИ. ОС ДУБНА ОТ … М1` | Banner at boot. |
| `name/N WNN` | Tape `name` with number `N` is modelled on logical unit `NN` (printed with ТР1 bit 24). |
| `Д-2000  МС-…` | Boot is complete: DD and the Monitor System drums (`МС-21,22`, or `МС-Ф10` when modelled on disk: see [Monsys9_Tape.md](Monsys9_Tape.md)). |
| `ВЫВОД БУФЕРИЗОВАН` | The output task started; output goes through the output file ([sluga.dd4:7216](../besmdisp/sluga.dd4#L7216)). |
| `МЛ ВЫВОДА!`, `МЛ ВВОДА !`, `МЛ ВВ/ВЫВ!` | The disk files D73OUT and/or D73INP were not found ([sluga.dd4:7210](../besmdisp/sluga.dd4#L7210)). |
| `ПЛОХ.КАТАЛ.ВЫВОДА` | The output catalogue is damaged. |
| `ПЛАНИРОВЩИК` | The planner started; jobs from the input file can run. |
| `nnШNN:NAME` | Job `NAME` (input file entry `nn`) started on Ш`NN`. |
| `ПФ-An-name` | Take the punched cards of `name` from punch `n`, then answer `nР`. |
| `NNNN-КШNN-hh.mm.ss-NAME` | Job `NAME` on Ш`NN` ended (seen for jobs from cards); the time is its commercial time. |
| `ВУ НЕ ВКЛ` | No card reader is ready: nothing attached, or the deck has run out. Normal after `ПВ` has taken the last deck. |
| `ВУ ЗАНЯТО` | The card reader is in use by another шифр. |
| `ОШ ВУ Кn` | Card reader fault, e.g. the deck ran out without an end-of-deck card. |
| `НЕТ ПК NАМЕ` | Batch input found a deck that does not start with `*NAME`. |

### Card decks

A deck is the same text as a Multitype job, from `*NAME` to `*END FILE`, followed by the
end-of-deck card ("диспетчерский конец": columns 1 and 41 punched in all twelve rows,
[dubna.dd:21824](../dub_besm/dubna.dd#L21824)). Several decks may follow each other for `ПВ`.
Text cards are accepted in both codes, the row-wise UPP and the column-wise UPDK; the
decoder tells them apart. In a SIMH deck file each line is a card, UPP by default
(`set vu0 updk` for UPDK), and a line of six backquotes is the end-of-deck card. DD is
configured with two column-wise readers (УВВК), which is what SIMH `vu0`, `vu1` model.
`BUILD/card-run.sh` runs a deck this way (`BUILD/card-run.ini`).

## Multitype

### Log in

| Step | Reply |
| --- | --- |
| Two spaces | Banner `МУЛЬТИТАЙП (ВЕРСИЯ ОТ 15/12/87) ЭВМ-0`, prompt `PASS:`. |
| Password, e.g. `MJPOP` (echo `*****`) | Prompt `БУФЕР:`. `НЕТ ТАКОГО` for a bad password; `ЗАНЯТ` if this password is already logged in on another line. |
| Buffer name, e.g. `7/M` | Prompt: a new line and 5 spaces. An empty answer reuses the previous buffer. |

The **buffer** is where the user's decks live: a tape (`7/M` is tape 7, which DD keeps on disk
from zone 0700), a drum, or a file of the file system (`SNAME,MASTER,FILE,REGIM`). Zone numbers
in commands are relative to the buffer. `БУФЕР:` comes back after a job is started, because
the start releases the buffer.

Multitype drops an idle line: after a while it prints `ВРЕМЯ` and `К О Н Е Ц`.

### How commands are read

Only the **first 3 characters** of a line are compared with table `CO CA`
([nrespost.dd3:12360](../besmdisp/nrespost.dd3#L12360)), so `ЛИС`, `ЛИСТ` and `ЛИСТИНГ` are one
command, and `ТЕЛЕГРАММА:` is `ТЕЛ`. Arguments follow after a space, separated by commas.
An **empty line** shows the next page inside a listing; otherwise it repeats the last command
if that was `КВЫ`, `КВВ`, `ОЧЕ`, `ИДИ`, `РЕГ`, `МЯЧ`, `ФЯЧ`, `ШАГ`, `ДЕС`, `КАК` or `СЧЕ`.
`%%%` cancels the SEND and ЖДУ modes.

### Session

| Command | Meaning |
| --- | --- |
| `СТО` (СТОП) | Release the buffer, print `К О Н Е Ц`, wait for a new login. |
| `К О Н` | End the session at once and free the line. |
| `ЖДУ` | Wait for output or input requests from my job. |
| `РЕТ` | Leave terminal / waiting mode. |
| `ТЕЛ text` | Send `text` to the operator console. |
| `СНА [ooo]` | Show or set the line characteristics (3 octal digits). |
| `EDI` | Switch to the screen editor (see below). Reply `ЖДИТЕ` if it is busy. |

### The buffer: listing and typing decks

| Command | Meaning |
| --- | --- |
| `ЛИС zone` | List the deck that starts at `zone`. `ЛИС zone+` adds line numbers. Empty line = next page. |
| `ДО text` | Inside a listing: skip to the line containing `text`. `НЕТ ОБРАЗА` if absent. |
| `ДОН n`, `ДОН +n` | Inside a listing: skip to line `n` / forward by `n`. |
| `ВЫВ L` | List `L` lines per page. |
| `ВВО z1[,z2]` | Type cards into the buffer from zone `z1` (up to `z2`), with numbered prompts. `ЗАПР.ЗАПИСЬ` if the buffer is read-only. |
| `ВБН z1[,z2]` | The same without line numbers. |
| `SEN z1[,z2]` | Input with completion (SEND mode). |
| `ИСК NN` | Remove file `NN` from the input buffer. Reply `ГОТОВ`. |
| `ФОР fields` | Pack a format: fields `A`, `S`, `X` with widths, up to 6; `L` = standard. |
| `ДЕЛ dddd` | The "delta" of the buffer tape. |

While cards are typed, Multitype prompts for control-card fields: `*PASS:`, `*TIME:`,
`*LIST OUT`, `*DISC:`, `*FILE:` after `*NAME`, and so on.

### Starting jobs

All start commands take `zone[,NN]`: the deck at `zone` of the buffer, and optionally the
шифр Ш`NN` to run on. A deck name may be given instead of a zone.

| Command | Start type | Meaning |
| --- | --- | --- |
| `ПУС` | 0 | Put the deck into the **input file**. Reply `ЖДИТЕ ОТВЕТА`, then `ПАКЕТ В ФАЙЛЕ ВВОДА: nn`. The planner starts it later, on a шифр it chooses, as a normal batch job with a listing. |
| `ТЕР` | 1 | Run in terminal mode. With no arguments: reconnect the terminal to my running job. |
| `TPR` | 1 | Terminal mode, printer output also allowed ("терминал+АЦПУ"). Latin `R`, as spelled in the table. |
| `TNP` | 1 | Terminal mode, printer output caught to the terminal ("перехват АЦПУ"). Latin `N`. |
| `ОТЛ` | 1 | Run under the debugger (stops at 100). |
| `СЛУ` | 2 | Run directly. |
| `СЛА` | 3 | Run directly with printer output blocked. |
| `СЛО` | 3 | `СЛА` under the debugger. |
| `RUN` | 3 | Like `СЛА` ("СЛА−СЛУ" in the table). |

The type goes into bits 13–12 of the job word INFEX ([nrespost.dd3:9466](../besmdisp/nrespost.dd3#L9466)).
For type 3 Multitype sets the job's bit in `БЛОКАЦПУ`, "блокировка вывода"
([nrespost.dd3:11303](../besmdisp/nrespost.dd3#L11303)): **a `СЛА` or `RUN` job prints
nothing, and leaves no listing in the output file.** To get a listing on the printer, use
`ПУС`.

Types 1–3 reply `СЧЕТ` and run at once, without the planner. They go through the planner
instead when DD was generated with a non-zero `*PL/MT` or ТР4 bits 24–1 are set
([nrespost.dd3:11126](../besmdisp/nrespost.dd3#L11126)). Other refusals:

- `ЗАПР!`: the operator has not allowed this terminal to start jobs, or debugging is not
  allowed for this job.
- `МНОГО ЗАДАЧ`: the queue is full, or I already have a type 1 or 2 job.
- `ОШ.ШИФР`: bad шифр. `ЗАНЯТ`: the шифр is busy.
- `*** ОТКАЗ: …` after `ПУС`: the deck could not be put into the input file
  (`ОШ. ВВОДА`, `ОШ. В ПАСП.`, `НЕТ ПК *NAME`, `АВАРИЯ`, `ОШ. СИСТЕМЫ`).

### Watching jobs

| Command | Meaning |
| --- | --- |
| `КАК` (КАК ДЕЛА) | My jobs, one line each. `НЕТ ЗАДАЧ` if none run. |
| `СЧЕ` | All running jobs on Ш20–Ш01, with time limits. |
| `КВЫ` | My entries in the output catalogue. |
| `КВВ` | My entries in the input catalogue. |
| `ОЧЕ` | The queue. |
| `РЕЗ NN` | Show listing `NN` of the output file on the terminal. `ПРОЧЬ` if there is none. |
| `ПЕЧ NN` | Send listing `NN` to the printer. |
| `НОВ` | Like `РЕЗ`, with a "new" mark (unclear). |
| `ПРТ [NN]` | Show my job's control cards on the terminal as they run. `ТРП` cancels. |

The `КАК` line ([nrespost.dd3:11445](../besmdisp/nrespost.dd3#L11445)), field layout
(the spacing is illustrative):

```
 Ш05: 00.12- 00.03-       ВЫ/ВВ=0101 НЕLLО
 │    │      │      │     │          └ job name
 │    │      │      │     └ output / input catalogue numbers
 │    │      │      └ waiting state: МЛ (tape), ГТ.МФ, or blank
 │    │      └ processor time, mm.ss
 │    └ elapsed time, mm.ss (СЧЕ adds the limit)
 └ шифр; '*' after it if the job was not started from this terminal
```

A job that is ending shows `СЧЕТ ОКОНЧЕН` instead of the times.

The `КВЫ` line has the form `ИСЫЫВВ NAME` ([nrespost.dd3:11824](../besmdisp/nrespost.dd3#L11824)):

- `И`, the source: blank = input device, `С` = network, `Т` = Multitype terminal.
- `С`, the state: blank = ready to print, `+` printing, `<` queued for printing,
  `*` printed, `/` dropped, `G` has graphics not yet output.
- `ЫЫ`, `ВВ`: numbers in the output and input catalogues.

`КВВ` uses `ИСВВ00 NAME`. Its state is `+` being entered, blank = ready for planning,
`/` running, `*` read.

### Controlling jobs

| Command | Meaning |
| --- | --- |
| `ОТК [NN]` | Kill my job on Ш`NN`, or all my jobs. Ends with `НЕТ ЗАДАЧ`. |
| `ПУЛ oooooooooooooooo` | Write 16 octal digits into my job's console word (cell 113). |
| `ПЛО n`, `ОПЛ` | Tape density for my job / standard density. |
| `АЦП` | Withdrawn: reply `*ПРИКАЗ ИЗ'ЯТ!*`. |

### Debugger

These work on a job started with `ОТЛ` or `СЛО`.

| Command | Meaning |
| --- | --- |
| `ОСА addr` | Stop when the command at `addr` executes. |
| `ОЗА addr` | Stop on a write to `addr`. |
| `ОЧТ addr` | Stop on a read of `addr`. |
| `ИДИ [addr]` | Continue (from `addr`). |
| `ШАГ` | Single-step mode. |
| `РЕГ` | Show the registers. |
| `МЯЧ addr` | Show a memory word in octal. |
| `МЯК addr` | Indirect read. |
| `ФЯЧ addr` | Read a physical address. |
| `ДЕС addr` | Show a word in decimal. |
| `ЗАП addr,value` | Write a word. |
| `ЧИЗ addr[,value]` | Write a number. |
| `ЛТО` | End debugging. |

### Multitype replies

| Reply | Meaning |
| --- | --- |
| `ОШ.Н.` | Bad arguments. |
| `ЖДИТЕ` | Busy: the job memory or the editor. Try again. |
| `ЗАПР!` | Not allowed. |
| `ЗАНЯТ` | Password or шифр already in use. |
| `НЕТ ТЕКСТА` | The data is not text. |
| `ВВОД`, `БУФЕР:` | Prompts after an unknown command (`БУФЕР:` if no buffer is set). |
| `МЛ НЕТ`, `МЛ ЗАНЯТА`, `НЕ ГОТОВ МФ`, `НЕТ ФАЙЛА`, `ФАЙЛ ЗАНЯТ`, `НЕТ ДОСТУПА` | Buffer could not be attached ([nrespost.dd3:2911](../besmdisp/nrespost.dd3#L2911)). |

## Screen editor

`EDI` passes the line to the editor ELINE by M. Popov ("ЭКРАННЫЙ РЕДАКТОР ВЕРСИЯ 1.1С",
[task11.ts1:7779](../besmtask/task11.ts1#L7779)). Its commands start with `#`:

| Command | Meaning |
| --- | --- |
| `#FILE:name[,…]` | Open a file (up to 4). |
| `#EDIT` | Edit the file. |
| `#LIST` | List from the current line. |
| `#INSERT` | Insert lines before the current line. |
| `#DELETE` | Delete lines. |
| `#+n`, `#-n` | Move by `n` lines. |
| `#+>text`, `#->text` | Search forward / back for `text`. |
| `#=`, `#?` | Table of open files. |
| `#SCREEN n`, `#TAB` | Screen size, tab stops. |
| `#SAVE` | Write the file: `ЗАПИСАНО nnnn ЗОН`. |
| `#END` | Exit; asks `А ГДЕ КОМАНДА SAVE ?` if not saved. |
| `#KILL` | Exit without saving. |

## In our scripts

| Script | Line | What it sends |
| --- | --- | --- |
| `BUILD/boot-run.py` | tty25 | empty line, `040489D`, `T`, `A1P` when the spooler asks (`-o`); after a `ПУС`, orders such as `01БП` (`-s`) |
| | tty26 | two spaces, `MJPOP`, `7/M`, `ЛИС zone` and an empty line, `СЛА zone,17` or `ПУС zone,17` (`-q`), `КАК` or `СЧЕ` (`-p`) until the job ends (`-m zone`) |
| `BUILD/boot-run.py deck` | tty25 | as above, then `01В` (`-r`) with the deck in `vu0` |
| `BUILD/card-run.ini` | tty25 | the same orders and `01В` from SIMH `send`, console on the terminal |
| `BUILD/mk-base.sh` | both | `boot-run.py deck` (`01В`) for the decks `newbsz` and `newdd`, then `boot-run.py -m 110` for hello |

The 2017 script `expe.ex` (removed) ran `newbsz` and `newdd` with `СЛА` on tty26, after
taking it as an operator console with `ОР` and giving it back with `REF`.

Notes:

- Deck zones of 7/M used here: 100 newdd, 105 newbsz, 110 hello.
- `СЛА` gives no listing (see [Starting jobs](#starting-jobs)); queue a job with `ПУС` to
  get it on the printer. `newbsz` and `newdd` ask for 24 minutes, so queued with `ПУС` the
  planner does not start them in debug mode; `NNБП` starts them at once. The build feeds
  them as card decks with `01В` instead.
- A listing that fills a page waits for a key: the first character typed after it is lost.
- The date must be in 1989.
