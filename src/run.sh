#!/bin/bash
for population in 100 200 300 400 500
do
	for numb_bits in 16 32 64 128 256 512
	do
		for corrida in 1 2 3 4 5 6 7 8 9 10 
		do 
			ruby GA.rb $numb_bits $population > logs/GA.log.$numb_bits-$population-$corrida
			ruby cGA.rb $numb_bits $population > logs/cGA.log.$numb_bits-$population-$corrida
		done
	done
done
