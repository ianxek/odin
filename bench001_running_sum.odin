// Running sum microbenchmark
//
// Yann Le Du
// December 2021
//
// We time the running sum of an array of i32s
// Benchmark idea taken from https://lemire.me/blog/2012/07/23/is-cc-worth-it/
//
// My best results were obtained with :
//
// odin build bench001.odin -o:speed -no-bounds-check 

package main

import "core:fmt"
import "core:c/libc"

main :: proc() {
    using fmt

    N :: 50_000_000
    Vector :: [dynamic]i32

    givemeanarray :: proc(N: u32) -> Vector {
        // Create an array of length N on the heap and return it filled it with values
        bigarray:= make(Vector, 0, N)
        for k :u32= 0; k< N; k+=1 do append(&bigarray, i32(k+k/3))
        return bigarray
    }

    runsumarray :: proc(arr: Vector) {
        // Perform an in place running sum on arr
        for _,i in arr {
            if i>0 do arr[i] += arr[i-1]
        }
    }

    showarray :: proc(arr: Vector, up:= 10) {
        // Display first up items of array arr
        for _,i in arr {
            if i < up do println(arr[i])
        }
    }


    // Creating the array on which to apply the running sum
    // I time it but that's not the point of this microbenchmark
    start := libc.clock()
    vals := givemeanarray(N)
    end := libc.clock()
    
    up := 10
    println("First",up,"values of array :")
    showarray(vals, up)

    println()
    println("Speed for filling up the array :")
    println("Millions of i32. per s :", f32(N)/(f32(end-start)/f32(libc.CLOCKS_PER_SEC))/1e6)

    // Now computing the running sum
    start = libc.clock()
    runsumarray(vals)
    end = libc.clock()
    
    up = 10
    println("First",up,"values of array :")
    showarray(vals)

    println()
    println("Speed for computing the running sum in-place :")
    println("Millions of i32. per s :", f32(N)/(f32(end-start)/f32(libc.CLOCKS_PER_SEC))/1e6)
}
