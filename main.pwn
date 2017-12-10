#include <a_samp>


static const UPDATE_INTERVAL = 100;     // frequency of timer creation and stat print
static const SAMPLES = 40;              // number of times to call update
static const WARM_UP_PERIOD = 10;       // ticks to run for before starting the tests
static const TIMERS_PER_UPDATE = 30000; // amount of timers to start on each update
static const TIMERS_INTERVAL = 1000;    // timer intervals
static const TIMERS_STAGGER = 0;        // whether or not to stagger the intervals
static lastID;
static tick;


main() {
    SetTimer("update", UPDATE_INTERVAL, true);
}

forward update();
public update() {
    if(tick < WARM_UP_PERIOD) {
        tick += 1;
        return;
    }

    if(tick == SAMPLES + WARM_UP_PERIOD) {
        return;
    }

    for(new i; i < TIMERS_PER_UPDATE; ++i) {
        lastID = SetTimer("none", TIMERS_INTERVAL + (TIMERS_STAGGER * i), true);
    }

    printf("[%04d]: lastID: %08d tickrate: %04d", tick - WARM_UP_PERIOD, lastID, GetServerTickRate());
    tick += 1;
}
