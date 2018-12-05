package com.example.sam.lab3;

/*
Name:       Sam Delaney
Student #:  564284
CMPT 360    Fall 2018
Lab 3:      Sieve of Erastosthenes
 */

import java.util.ArrayList;
import java.util.List;

public class Sieve_of_Erastosthenes {

    private boolean[] numbers;
    private int high;

    public Sieve_of_Erastosthenes(int input) {
        high = input;
        numbers = new boolean[high];
    }

    //calculate the prime numbers below the input number,
    public long run_sieve()
    {
        long start_time = System.nanoTime();

        //start at the second index, because 1 is not prime
        for(int i = 2; i < high; i++)
        {
            //skip the number if it has already been 'crossed out'
            if(numbers[i] == false) {
                for (int j = 2 * i; j < high; j += i) {
                    numbers[j] = true;
                }
            }
        }

        return System.nanoTime() - start_time;
    }

    public List<Integer> getNumbers()
    {
        List<Integer> primes = new ArrayList<Integer>() ;

        for(int i = 2; i < numbers.length; i++)
        {
            if(numbers[i] == false)
                primes.add(i);
        }

        return primes;
    }

}
