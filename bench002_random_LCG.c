// Linear congruential random generator microbenchmark
// Idea taken from https://lemire.me/blog/2016/02/01/default-random-number-generators-are-slow/
//
//Code taken from https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2018/01/02/simdfasta.c
//
// Yann Le Du
// December 2021
//
// Compile :
// gcc -Ofast -o bench002_random_LCG bench002_random_LCG.c

#include <stdlib.h>
#include <time.h>
#include <stdio.h>



// Generate a floating point pseudorandom number from 0.0 to max using a linear
// congruential generator.
#define IM 139968
#define IA 3877
#define IC 29573
#define SEED 42
#define N 50000000

static inline float get_LCG_Pseudorandom_Number(const float max) {
  static uint32_t seed = SEED;
  seed = (seed * IA + IC) % IM;
  return max / IM * seed;
}

int main(int argc, char **argv) {
    float r = 0;
    clock_t begin, end;
    double duration;
    const float MAX = 100;

    begin = clock();
    for (int i=0; i < N; i++) {
        r = get_LCG_Pseudorandom_Number(MAX);
    }
    end = clock();

    printf("Begin : %lu\nEnd : %lu\n",begin,end);
    duration = (double)(end - begin) / (double)CLOCKS_PER_SEC;
    printf("Total time taken by CPU (s): %f\n", duration  );
    printf("Millions of random floats between 0 and %f : %f\n", MAX, N / duration / 1e6);
}
