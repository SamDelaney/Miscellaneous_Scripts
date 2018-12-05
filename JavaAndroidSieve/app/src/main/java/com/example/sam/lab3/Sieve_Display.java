/*
Name:       Sam Delaney
Student #:  564284
CMPT 360    Fall 2018
Lab 3:      Sieve of Erastosthenes
 */


package com.example.sam.lab3;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

import static android.app.PendingIntent.getActivity;

public class Sieve_Display extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sieve__display);

        Button runButton = (Button) findViewById(R.id.button);
        final ListView primesList = (ListView) findViewById(R.id.primesList);

        runButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                EditText userInput  = (EditText) findViewById(R.id.editText);
                int input = Integer.parseInt(userInput.getText().toString());

                Sieve_of_Erastosthenes soe = new Sieve_of_Erastosthenes(input);
                long timeTaken = soe.run_sieve();
                double milliseconds = (double)timeTaken / 1000000.0;
                userInput.setText("Time: " + milliseconds + " ms.");

                primesList.setAdapter(new ArrayAdapter<Integer>(Sieve_Display.this, R.layout.prime_list_details, soe.getNumbers()));
            }
        });
    }


}
