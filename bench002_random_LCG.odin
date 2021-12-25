// Running sum microbenchmark
//
// Yann Le Du
// December 2021
//
// We time a random generator based on a simple linear congruential generator.
// Idea taken from https://lemire.me/blog/2016/02/01/default-random-number-generators-are-slow/
//
// My best results were obtained with :
//
// odin build bench002_random_LCG.odin -o:speed -no-bounds-check 

package main

import "core:fmt"
import "core:c/libc"
N :: 50_000_000
IM :: 139968
IA :: 3877
IC :: 29573
SEED :: 42
MAX :: 100

// Generate a floating point pseudorandom number from 0.0 to max using a linear
// congruential generator.
get_LCG_Pseudorandom_Number :: proc(max : f32 = IM) -> f32 {
    @static seed : u32 = SEED;
    seed = ( seed * IA + IC ) % IM;
    return max / IM * f32(seed)
}

main :: proc() {
    using fmt

    r : f32 = 0
    start := libc.clock()
    for i := 0; i < N; i += 1 do r = get_LCG_Pseudorandom_Number(MAX)
    end := libc.clock()
    
    duration := f32(end - start)/f32(libc.CLOCKS_PER_SEC)
    println()
    printf("Total time taken by CPU (s): %f\n", duration)
    println("Millions of i32. per s :", f32(N) / duration / 1e6)
}
