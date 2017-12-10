# Timer benchmarks

Benchmarks for timers in SA:MP.

## Running the Code

This is a Pawn package and can be built/run with sampctl:

```bash
sampctl package ensure
sampctl package build
sampctl package run
```

## Introduction

The tables below show a sample taken every 100ms with an ever-increasing amount
of timers.

The test works by calling `update()` every 100ms and on each call, X amount of
new timers were created. `update()` is called 40 times per test meaning some
tests created 40,000 timers and some created 400,000!

Different configurations were tested:

* `TIMERS_PER_UPDATE`: Amount of new timers to create on each 100ms update. Two
  values were tested: 1k and 10k.
* `TIMERS_INTERVAL`: The interval parameter for the new timers.
* `TIMERS_STAGGER`: Whether or not to add a little bit to the interval for each
  new timer in order to make all the callbacks trigger at slightly different
  times.

The `lastID` values show the last `SetTimer` return - or, in this case (since
we're not killing any timers) the amount of timers currently running.

The `tickrate` values show the output of `GetServerTickrate` which is
essentially the server's version of FPS. This is a rough guide to server
performance, most of the time it should be sticking around 150-180. Dropping
below 100 means degraded server performance and slower update response for
players and sync.

## Test group 1: no staggering between timers

4 tests where the timers per second is tried with two different intervals. In
the high amounts of timers, the shorter interval has an effect on performance
however, in lower numbers it has much less of an effect.

|                                         |                                         |                                         |                                         |
| --------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     |
| static const SAMPLES = 40;              | static const SAMPLES = 40;              | static const SAMPLES = 40;              | static const SAMPLES = 40;              |
| static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       |
| static const TIMERS_PER_UPDATE = 1000;  | static const TIMERS_PER_UPDATE = 1000;  | static const TIMERS_PER_UPDATE = 10000; | static const TIMERS_PER_UPDATE = 10000; |
| static const TIMERS_INTERVAL = 1000;    | static const TIMERS_INTERVAL = 10;      | static const TIMERS_INTERVAL = 1000;    | static const TIMERS_INTERVAL = 10;      |
| static const TIMERS_STAGGER = 0;        | static const TIMERS_STAGGER = 0;        | static const TIMERS_STAGGER = 0;        | static const TIMERS_STAGGER = 0;        |
| [0000]: lastID: 00001001 tickrate: 0163 | [0000]: lastID: 00001001 tickrate: 0164 | [0000]: lastID: 00010001 tickrate: 0163 | [0000]: lastID: 00010001 tickrate: 0164 |
| [0001]: lastID: 00002001 tickrate: 0163 | [0001]: lastID: 00002001 tickrate: 0164 | [0001]: lastID: 00020001 tickrate: 0163 | [0001]: lastID: 00020001 tickrate: 0164 |
| [0002]: lastID: 00003001 tickrate: 0163 | [0002]: lastID: 00003001 tickrate: 0164 | [0002]: lastID: 00030001 tickrate: 0163 | [0002]: lastID: 00030001 tickrate: 0164 |
| [0003]: lastID: 00004001 tickrate: 0163 | [0003]: lastID: 00004001 tickrate: 0164 | [0003]: lastID: 00040001 tickrate: 0163 | [0003]: lastID: 00040001 tickrate: 0164 |
| [0004]: lastID: 00005001 tickrate: 0163 | [0004]: lastID: 00005001 tickrate: 0164 | [0004]: lastID: 00050001 tickrate: 0163 | [0004]: lastID: 00050001 tickrate: 0164 |
| [0005]: lastID: 00006001 tickrate: 0163 | [0005]: lastID: 00006001 tickrate: 0164 | [0005]: lastID: 00060001 tickrate: 0163 | [0005]: lastID: 00060001 tickrate: 0164 |
| [0006]: lastID: 00007001 tickrate: 0163 | [0006]: lastID: 00007001 tickrate: 0164 | [0006]: lastID: 00070001 tickrate: 0163 | [0006]: lastID: 00070001 tickrate: 0164 |
| [0007]: lastID: 00008001 tickrate: 0173 | [0007]: lastID: 00008001 tickrate: 0174 | [0007]: lastID: 00080001 tickrate: 0153 | [0007]: lastID: 00080001 tickrate: 0145 |
| [0008]: lastID: 00009001 tickrate: 0173 | [0008]: lastID: 00009001 tickrate: 0174 | [0008]: lastID: 00090001 tickrate: 0153 | [0008]: lastID: 00090001 tickrate: 0145 |
| [0009]: lastID: 00010001 tickrate: 0173 | [0009]: lastID: 00010001 tickrate: 0174 | [0009]: lastID: 00100001 tickrate: 0153 | [0009]: lastID: 00100001 tickrate: 0145 |
| [0010]: lastID: 00011001 tickrate: 0173 | [0010]: lastID: 00011001 tickrate: 0174 | [0010]: lastID: 00110001 tickrate: 0153 | [0010]: lastID: 00110001 tickrate: 0145 |
| [0011]: lastID: 00012001 tickrate: 0173 | [0011]: lastID: 00012001 tickrate: 0174 | [0011]: lastID: 00120001 tickrate: 0153 | [0011]: lastID: 00120001 tickrate: 0145 |
| [0012]: lastID: 00013001 tickrate: 0173 | [0012]: lastID: 00013001 tickrate: 0174 | [0012]: lastID: 00130001 tickrate: 0153 | [0012]: lastID: 00130001 tickrate: 0145 |
| [0013]: lastID: 00014001 tickrate: 0173 | [0013]: lastID: 00014001 tickrate: 0174 | [0013]: lastID: 00140001 tickrate: 0153 | [0013]: lastID: 00140001 tickrate: 0145 |
| [0014]: lastID: 00015001 tickrate: 0173 | [0014]: lastID: 00015001 tickrate: 0174 | [0014]: lastID: 00150001 tickrate: 0153 | [0014]: lastID: 00150001 tickrate: 0145 |
| [0015]: lastID: 00016001 tickrate: 0173 | [0015]: lastID: 00016001 tickrate: 0174 | [0015]: lastID: 00160001 tickrate: 0153 | [0015]: lastID: 00160001 tickrate: 0145 |
| [0016]: lastID: 00017001 tickrate: 0173 | [0016]: lastID: 00017001 tickrate: 0165 | [0016]: lastID: 00170001 tickrate: 0101 | [0016]: lastID: 00170001 tickrate: 0080 |
| [0017]: lastID: 00018001 tickrate: 0173 | [0017]: lastID: 00018001 tickrate: 0165 | [0017]: lastID: 00180001 tickrate: 0101 | [0017]: lastID: 00180001 tickrate: 0080 |
| [0018]: lastID: 00019001 tickrate: 0173 | [0018]: lastID: 00019001 tickrate: 0165 | [0018]: lastID: 00190001 tickrate: 0101 | [0018]: lastID: 00190001 tickrate: 0080 |
| [0019]: lastID: 00020001 tickrate: 0173 | [0019]: lastID: 00020001 tickrate: 0165 | [0019]: lastID: 00200001 tickrate: 0101 | [0019]: lastID: 00200001 tickrate: 0080 |
| [0020]: lastID: 00021001 tickrate: 0173 | [0020]: lastID: 00021001 tickrate: 0165 | [0020]: lastID: 00210001 tickrate: 0101 | [0020]: lastID: 00210001 tickrate: 0080 |
| [0021]: lastID: 00022001 tickrate: 0173 | [0021]: lastID: 00022001 tickrate: 0165 | [0021]: lastID: 00220001 tickrate: 0101 | [0021]: lastID: 00220001 tickrate: 0080 |
| [0022]: lastID: 00023001 tickrate: 0173 | [0022]: lastID: 00023001 tickrate: 0165 | [0022]: lastID: 00230001 tickrate: 0101 | [0022]: lastID: 00230001 tickrate: 0080 |
| [0023]: lastID: 00024001 tickrate: 0173 | [0023]: lastID: 00024001 tickrate: 0165 | [0023]: lastID: 00240001 tickrate: 0101 | [0023]: lastID: 00240001 tickrate: 0080 |
| [0024]: lastID: 00025001 tickrate: 0173 | [0024]: lastID: 00025001 tickrate: 0165 | [0024]: lastID: 00250001 tickrate: 0101 | [0024]: lastID: 00250001 tickrate: 0080 |
| [0025]: lastID: 00026001 tickrate: 0162 | [0025]: lastID: 00026001 tickrate: 0155 | [0025]: lastID: 00260001 tickrate: 0077 | [0025]: lastID: 00260001 tickrate: 0054 |
| [0026]: lastID: 00027001 tickrate: 0162 | [0026]: lastID: 00027001 tickrate: 0155 | [0026]: lastID: 00270001 tickrate: 0077 | [0026]: lastID: 00270001 tickrate: 0054 |
| [0027]: lastID: 00028001 tickrate: 0162 | [0027]: lastID: 00028001 tickrate: 0155 | [0027]: lastID: 00280001 tickrate: 0077 | [0027]: lastID: 00280001 tickrate: 0054 |
| [0028]: lastID: 00029001 tickrate: 0162 | [0028]: lastID: 00029001 tickrate: 0155 | [0028]: lastID: 00290001 tickrate: 0077 | [0028]: lastID: 00290001 tickrate: 0054 |
| [0029]: lastID: 00030001 tickrate: 0162 | [0029]: lastID: 00030001 tickrate: 0155 | [0029]: lastID: 00300001 tickrate: 0077 | [0029]: lastID: 00300001 tickrate: 0054 |
| [0030]: lastID: 00031001 tickrate: 0162 | [0030]: lastID: 00031001 tickrate: 0155 | [0030]: lastID: 00310001 tickrate: 0077 | [0030]: lastID: 00310001 tickrate: 0054 |
| [0031]: lastID: 00032001 tickrate: 0162 | [0031]: lastID: 00032001 tickrate: 0155 | [0031]: lastID: 00320001 tickrate: 0077 | [0031]: lastID: 00320001 tickrate: 0054 |
| [0032]: lastID: 00033001 tickrate: 0162 | [0032]: lastID: 00033001 tickrate: 0155 | [0032]: lastID: 00330001 tickrate: 0077 | [0032]: lastID: 00330001 tickrate: 0054 |
| [0033]: lastID: 00034001 tickrate: 0162 | [0033]: lastID: 00034001 tickrate: 0155 | [0033]: lastID: 00340001 tickrate: 0077 | [0033]: lastID: 00340001 tickrate: 0054 |
| [0034]: lastID: 00035001 tickrate: 0160 | [0034]: lastID: 00035001 tickrate: 0145 | [0034]: lastID: 00350001 tickrate: 0077 | [0034]: lastID: 00350001 tickrate: 0042 |
| [0035]: lastID: 00036001 tickrate: 0160 | [0035]: lastID: 00036001 tickrate: 0145 | [0035]: lastID: 00360001 tickrate: 0060 | [0035]: lastID: 00360001 tickrate: 0042 |
| [0036]: lastID: 00037001 tickrate: 0160 | [0036]: lastID: 00037001 tickrate: 0145 | [0036]: lastID: 00370001 tickrate: 0060 | [0036]: lastID: 00370001 tickrate: 0042 |
| [0037]: lastID: 00038001 tickrate: 0160 | [0037]: lastID: 00038001 tickrate: 0145 | [0037]: lastID: 00380001 tickrate: 0060 | [0037]: lastID: 00380001 tickrate: 0042 |
| [0038]: lastID: 00039001 tickrate: 0160 | [0038]: lastID: 00039001 tickrate: 0145 | [0038]: lastID: 00390001 tickrate: 0060 | [0038]: lastID: 00390001 tickrate: 0042 |
| [0039]: lastID: 00040001 tickrate: 0160 | [0039]: lastID: 00040001 tickrate: 0145 | [0039]: lastID: 00400001 tickrate: 0060 | [0039]: lastID: 00400001 tickrate: 0042 |

## Test group 2: staggering between timers

Same 4 configurations as above but this time, timers are given staggered
intervals so they don't all fire at once. This technique is used in timer
libraries to reduce server load and eliminate sudden bursts of processing. This
isn't really a proper test of staggering however, but I thought I'd include it
anyway since the results differ a bit. This seems to make a difference on the
higher frequency timers more than the lower frequency ones, probably because
there would be a lot of overlap with the lower ones.

|                                         |                                         |                                         |                                         |
| --------------------------------------- | --------------------------------------- | --------------------------------------- | --------------------------------------- |
| static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     | static const UPDATE_INTERVAL = 100;     |
| static const SAMPLES = 40;              | static const SAMPLES = 40;              | static const SAMPLES = 40;              | static const SAMPLES = 40;              |
| static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       | static const WARM_UP_PERIOD = 10;       |
| static const TIMERS_PER_UPDATE = 1000;  | static const TIMERS_PER_UPDATE = 1000;  | static const TIMERS_PER_UPDATE = 10000; | static const TIMERS_PER_UPDATE = 10000; |
| static const TIMERS_INTERVAL = 1000;    | static const TIMERS_INTERVAL = 10;      | static const TIMERS_INTERVAL = 1000;    | static const TIMERS_INTERVAL = 10;      |
| static const TIMERS_STAGGER = 1;        | static const TIMERS_STAGGER = 1;        | static const TIMERS_STAGGER = 1;        | static const TIMERS_STAGGER = 1;        |
| [0000]: lastID: 00001001 tickrate: 0163 | [0000]: lastID: 00001001 tickrate: 0164 | [0000]: lastID: 00010001 tickrate: 0164 | [0000]: lastID: 00010001 tickrate: 0165 |
| [0001]: lastID: 00002001 tickrate: 0163 | [0001]: lastID: 00002001 tickrate: 0164 | [0001]: lastID: 00020001 tickrate: 0164 | [0001]: lastID: 00020001 tickrate: 0165 |
| [0002]: lastID: 00003001 tickrate: 0163 | [0002]: lastID: 00003001 tickrate: 0164 | [0002]: lastID: 00030001 tickrate: 0164 | [0002]: lastID: 00030001 tickrate: 0165 |
| [0003]: lastID: 00004001 tickrate: 0163 | [0003]: lastID: 00004001 tickrate: 0164 | [0003]: lastID: 00040001 tickrate: 0164 | [0003]: lastID: 00040001 tickrate: 0165 |
| [0004]: lastID: 00005001 tickrate: 0163 | [0004]: lastID: 00005001 tickrate: 0164 | [0004]: lastID: 00050001 tickrate: 0164 | [0004]: lastID: 00050001 tickrate: 0165 |
| [0005]: lastID: 00006001 tickrate: 0163 | [0005]: lastID: 00006001 tickrate: 0164 | [0005]: lastID: 00060001 tickrate: 0164 | [0005]: lastID: 00060001 tickrate: 0165 |
| [0006]: lastID: 00007001 tickrate: 0163 | [0006]: lastID: 00007001 tickrate: 0164 | [0006]: lastID: 00070001 tickrate: 0164 | [0006]: lastID: 00070001 tickrate: 0165 |
| [0007]: lastID: 00008001 tickrate: 0175 | [0007]: lastID: 00008001 tickrate: 0177 | [0007]: lastID: 00080001 tickrate: 0155 | [0007]: lastID: 00080001 tickrate: 0154 |
| [0008]: lastID: 00009001 tickrate: 0175 | [0008]: lastID: 00009001 tickrate: 0177 | [0008]: lastID: 00090001 tickrate: 0155 | [0008]: lastID: 00090001 tickrate: 0154 |
| [0009]: lastID: 00010001 tickrate: 0175 | [0009]: lastID: 00010001 tickrate: 0177 | [0009]: lastID: 00100001 tickrate: 0155 | [0009]: lastID: 00100001 tickrate: 0154 |
| [0010]: lastID: 00011001 tickrate: 0175 | [0010]: lastID: 00011001 tickrate: 0177 | [0010]: lastID: 00110001 tickrate: 0155 | [0010]: lastID: 00110001 tickrate: 0154 |
| [0011]: lastID: 00012001 tickrate: 0175 | [0011]: lastID: 00012001 tickrate: 0177 | [0011]: lastID: 00120001 tickrate: 0155 | [0011]: lastID: 00120001 tickrate: 0154 |
| [0012]: lastID: 00013001 tickrate: 0175 | [0012]: lastID: 00013001 tickrate: 0177 | [0012]: lastID: 00130001 tickrate: 0155 | [0012]: lastID: 00130001 tickrate: 0154 |
| [0013]: lastID: 00014001 tickrate: 0175 | [0013]: lastID: 00014001 tickrate: 0177 | [0013]: lastID: 00140001 tickrate: 0155 | [0013]: lastID: 00140001 tickrate: 0154 |
| [0014]: lastID: 00015001 tickrate: 0175 | [0014]: lastID: 00015001 tickrate: 0177 | [0014]: lastID: 00150001 tickrate: 0155 | [0014]: lastID: 00150001 tickrate: 0154 |
| [0015]: lastID: 00016001 tickrate: 0175 | [0015]: lastID: 00016001 tickrate: 0177 | [0015]: lastID: 00160001 tickrate: 0155 | [0015]: lastID: 00160001 tickrate: 0154 |
| [0016]: lastID: 00017001 tickrate: 0174 | [0016]: lastID: 00017001 tickrate: 0173 | [0016]: lastID: 00170001 tickrate: 0104 | [0016]: lastID: 00170001 tickrate: 0104 |
| [0017]: lastID: 00018001 tickrate: 0174 | [0017]: lastID: 00018001 tickrate: 0173 | [0017]: lastID: 00180001 tickrate: 0104 | [0017]: lastID: 00180001 tickrate: 0104 |
| [0018]: lastID: 00019001 tickrate: 0174 | [0018]: lastID: 00019001 tickrate: 0173 | [0018]: lastID: 00190001 tickrate: 0104 | [0018]: lastID: 00190001 tickrate: 0104 |
| [0019]: lastID: 00020001 tickrate: 0174 | [0019]: lastID: 00020001 tickrate: 0173 | [0019]: lastID: 00200001 tickrate: 0104 | [0019]: lastID: 00200001 tickrate: 0104 |
| [0020]: lastID: 00021001 tickrate: 0174 | [0020]: lastID: 00021001 tickrate: 0173 | [0020]: lastID: 00210001 tickrate: 0104 | [0020]: lastID: 00210001 tickrate: 0104 |
| [0021]: lastID: 00022001 tickrate: 0174 | [0021]: lastID: 00022001 tickrate: 0173 | [0021]: lastID: 00220001 tickrate: 0104 | [0021]: lastID: 00220001 tickrate: 0104 |
| [0022]: lastID: 00023001 tickrate: 0174 | [0022]: lastID: 00023001 tickrate: 0173 | [0022]: lastID: 00230001 tickrate: 0104 | [0022]: lastID: 00230001 tickrate: 0104 |
| [0023]: lastID: 00024001 tickrate: 0174 | [0023]: lastID: 00024001 tickrate: 0173 | [0023]: lastID: 00240001 tickrate: 0104 | [0023]: lastID: 00240001 tickrate: 0104 |
| [0024]: lastID: 00025001 tickrate: 0174 | [0024]: lastID: 00025001 tickrate: 0173 | [0024]: lastID: 00250001 tickrate: 0104 | [0024]: lastID: 00250001 tickrate: 0104 |
| [0025]: lastID: 00026001 tickrate: 0163 | [0025]: lastID: 00026001 tickrate: 0161 | [0025]: lastID: 00260001 tickrate: 0078 | [0025]: lastID: 00260001 tickrate: 0078 |
| [0026]: lastID: 00027001 tickrate: 0163 | [0026]: lastID: 00027001 tickrate: 0161 | [0026]: lastID: 00270001 tickrate: 0078 | [0026]: lastID: 00270001 tickrate: 0078 |
| [0027]: lastID: 00028001 tickrate: 0163 | [0027]: lastID: 00028001 tickrate: 0161 | [0027]: lastID: 00280001 tickrate: 0078 | [0027]: lastID: 00280001 tickrate: 0078 |
| [0028]: lastID: 00029001 tickrate: 0163 | [0028]: lastID: 00029001 tickrate: 0161 | [0028]: lastID: 00290001 tickrate: 0078 | [0028]: lastID: 00290001 tickrate: 0078 |
| [0029]: lastID: 00030001 tickrate: 0163 | [0029]: lastID: 00030001 tickrate: 0161 | [0029]: lastID: 00300001 tickrate: 0078 | [0029]: lastID: 00300001 tickrate: 0078 |
| [0030]: lastID: 00031001 tickrate: 0163 | [0030]: lastID: 00031001 tickrate: 0161 | [0030]: lastID: 00310001 tickrate: 0078 | [0030]: lastID: 00310001 tickrate: 0078 |
| [0031]: lastID: 00032001 tickrate: 0163 | [0031]: lastID: 00032001 tickrate: 0161 | [0031]: lastID: 00320001 tickrate: 0078 | [0031]: lastID: 00320001 tickrate: 0078 |
| [0032]: lastID: 00033001 tickrate: 0163 | [0032]: lastID: 00033001 tickrate: 0161 | [0032]: lastID: 00330001 tickrate: 0078 | [0032]: lastID: 00330001 tickrate: 0078 |
| [0033]: lastID: 00034001 tickrate: 0163 | [0033]: lastID: 00034001 tickrate: 0161 | [0033]: lastID: 00340001 tickrate: 0078 | [0033]: lastID: 00340001 tickrate: 0078 |
| [0034]: lastID: 00035001 tickrate: 0157 | [0034]: lastID: 00035001 tickrate: 0156 | [0034]: lastID: 00350001 tickrate: 0063 | [0034]: lastID: 00350001 tickrate: 0078 |
| [0035]: lastID: 00036001 tickrate: 0157 | [0035]: lastID: 00036001 tickrate: 0156 | [0035]: lastID: 00360001 tickrate: 0063 | [0035]: lastID: 00360001 tickrate: 0061 |
| [0036]: lastID: 00037001 tickrate: 0157 | [0036]: lastID: 00037001 tickrate: 0156 | [0036]: lastID: 00370001 tickrate: 0063 | [0036]: lastID: 00370001 tickrate: 0061 |
| [0037]: lastID: 00038001 tickrate: 0157 | [0037]: lastID: 00038001 tickrate: 0156 | [0037]: lastID: 00380001 tickrate: 0063 | [0037]: lastID: 00380001 tickrate: 0061 |
| [0038]: lastID: 00039001 tickrate: 0157 | [0038]: lastID: 00039001 tickrate: 0156 | [0038]: lastID: 00390001 tickrate: 0063 | [0038]: lastID: 00390001 tickrate: 0061 |
| [0039]: lastID: 00040001 tickrate: 0157 | [0039]: lastID: 00040001 tickrate: 0156 | [0039]: lastID: 00400001 tickrate: 0063 | [0039]: lastID: 00400001 tickrate: 0061 |

## Conclusion

Timers are cheap. I can easily run 20-30 thousand timers with no apparent
degredation in tickrate.

Now, what code you put in your interval callbacks is a different story...

_just for fun..._ `[0499]: lastID: 05000001 tickrate: 0006`
