#!/bin/bash
for population in 100 200 300 400 500
do
	for numb_bits in 16 32 64 128 256 512
	do
		for corrida in 1 2 3 4 5 6 7 8 9 10 
		do 
			grep Total: logs/cGA.log.$numb_bits-$population-$corrida >> results/cGA.$numb_bits-$population-memory
			grep Total: logs/GA.log.$numb_bits-$population-$corrida >> results/GA.$numb_bits-$population-memory
			tail -n 32 logs/cGA.log.$numb_bits-$population-$corrida | grep iteration >> results/cGA.$numb_bits-$population-iteraciones
			tail -n 43 logs/GA.log.$numb_bits-$population-$corrida | grep gen >> results/GA.$numb_bits-$population-iteraciones
		done
	done
done
