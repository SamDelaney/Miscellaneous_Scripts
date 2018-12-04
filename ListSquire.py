# Name: Sam Delaney
# Student Number: 564284
# CMPT 360 Fall 2018
# Assignment #3
# Implementing a Doubly Linked List

#!/usr/bin/env python

#---------------Import necessary libraries--------------#

from guizero import App, Text, PushButton, Box, TextBox


#-----------------Establish UI structure----------------#

app = App(title = "ListSquire", layout="grid", width=700)
textBox = Box(app, align="top", grid=[0,0])
inputBox = Box(app, align="top", grid=[0,1], layout="grid")
buttonBox = Box(app, align = "bottom", grid = [0,2], layout="grid")


#---------------Create Doubly Linked List---------------#

class node:
	def __init__(self, p, n, val):
		self.value = val
		self.previous = p
		self.next = n

		#a zero denotes the start or end of the list
		if(self.previous != 0):
			self.previous.next = self
		if(self.next != 0):
			self.next.previous = self

curNode = node(0, 0, "Welcome to ListSquire!\n\n"
                "To create a new list, click the 'Add Page' button below.\n"
                "This page will be inserted immediately after the one you were previously viewing.\n\n"
                "To add a line to a list, type in the box below. \n"
                "To add this to the current list, hit the 'Add' button.\n"
                "To add it to a new list, hit the 'Add Page' button below.\n\n"
                "You can use the 'Previous Page' and 'Next Page' buttons to navigate between lists.\n\n"
                "If something's not quite behaving the way you expect, check below the buttons for a warning message.")

#--------------------Helping Functions------------------#

def next_page():
        global curNode
        if(curNode.next == 0):
                warnings.value = "End of document!"
        else:
                warnings.clear()
                curNode = curNode.next
        #print("Attempting Move Forward 1 Page: " + curNode.value) #DEBUG: comment out for standard version
        refresh()

def previous_page():
        global curNode
        if(curNode.previous == 0):
                warnings.value = "Start of document!"
        else:
                warnings.clear()
                curNode = curNode.previous
        #print("Attempting Move Back 1 Page: " + curNode.value) #DEBUG: comment out for standard version
        refresh()

def add_page():
        global curNode
        newNode = node(curNode, curNode.next, inputField.value)
        #print("Adding Page: " + newNode.value) #DEBUG: comment out for standard version
        next_page()

#adds user input to page content on new line
def add_phrase():
        global curNode
        #print("Adding Phrase: " + inputField.value) #DEBUG: comment out for standard version
        curNode.value = curNode.value + "\n" + inputField.value
        refresh()

def refresh():
        global curNode
        message.value = curNode.value
        #print("Current page: \n " + message.value) #DEBUG: comment out for standard version


#---------------Populate UI with elements--------------#

#top row: display
message = Text(textBox, grid=[0,1])

#middle row: input
inputField = TextBox(inputBox, grid=[0,0])
add_button = PushButton(inputBox, text="Add", command=add_phrase, grid=[1,0])

#bottom row: buttons
next_button = PushButton(buttonBox, text="  Next Page  ", command=next_page, grid=[2,2])
prev_button = PushButton(buttonBox, text="Previous Page", command=previous_page, grid=[0,2])
addPage_button = PushButton(buttonBox, text="  Add Page  ", command=add_page, grid=[1,2])

#warning label
warnings = Text(buttonBox, grid=[1,3])

#create window
message.value = curNode.value
app.display()

#print("Sam Delaney, CMPT 360, 10-12-18") #DEBUG: comment out for standard version

