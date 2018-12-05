//Sam Delaney
//Student Number: 564284
//CMPT 360 Fall 2018
//Lab 4
//Sieve of Erastosthenes

import React from 'react';
import { StyleSheet, Text, TextInput, Button, ScrollView, View } from 'react-native';

export default class App extends React.Component {
	constructor()
	{
		super()
		this.state = {
			timerText: "Enter a number < 2",
			inputText: "10000"
		}
		this.primes = [];
		this.boolKey = [];
	}
	
  render() {
	  
    return (
      <View style={styles.container}>
		<View style={styles.container}>
		
			<Text style = {styles.text}>{this.state.timerText}</Text>
			
			<TextInput
			style={{width: 150}}
			onChangeText={(text) => this.setState({this.inputText: text})}
			/>
			<Button
				onPress={() => {
					this.setState({
						timerText: "Time: " + this.run_sieve(inputText) + " ms."
						});
					this.getNumbers();
					
				}}
				title="Calculate Primes"
			/>
		</View>
		<ScrollView style={styles.scrollContainer}>
		{
 
          this.primes.map(( item, key ) =>
          (
            <View key = { key } style = { styles.item }>
 
 
                <Text style = { styles.item_text_style } >{ item }</Text>
 
 
                <View style = { styles.item_separator }/>
 
 
            </View>
          ))
        
        }
		</ScrollView>
	  </View>
 );
  }
  
	run_sieve(input) 
	{	
		var start_time = performance.now();
	
		var i;
		for(i = 2; i < input; i++)
		{
			this.boolKey.push(false);
		}
	
		for (i = 2; i < this.boolKey.length; i++)
		{
			if (this.boolKey[i] == false)
			{
				var j;
				for(j = 2 * i; j < this.boolKey.length; j += i)
				{
					this.boolKey[j] = true;
				}
			}
		}
		return performance.now() - start_time;
	}
	
	getNumbers()
	{
		for (i = 2; i < this.boolKey.length; i++)
		{
			if(this.boolKey[i] == false)
			{
				this.primes.push(i);
			}
		}
	}
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});




