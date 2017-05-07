#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define MAX_ITEMS 10

int items = 0;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

void produce() {
  // TODO ensure proper synchronization
  assert (items < MAX_ITEMS);
  items++;
  histogram [items] += 1;
}

void consume() {
  // TODO ensure proper synchronization
  assert (items > 0);
  items--;
  histogram [items] += 1;
}

void producer() {
  // TODO - You might have to change this procedure slightly
  for (int i=0; i < NUM_ITERATIONS; i++)
    produce();
}

void consumer() {
  // TODO - You might have to change this procedure slightly
  for (int i=0; i< NUM_ITERATIONS; i++)
    consume();
}

int main (int argc, char** argv) {
  // TODO create threads to run the producers and consumers
  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}