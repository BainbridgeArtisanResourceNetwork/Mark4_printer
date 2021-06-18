#! /bin/python 3
''' 
This python script looks through the input gcode file for lines with comments
that begin with "!". It strips off any characters preceeding the comment, and also the ":!

Then it saves these lines into a file of the same name but with an "md file extension.

The purpose is to allow simple extraction of an MD file for any gcode file that was 
written with the "!" comments. All MD formatting should work when the resulting file 
is viewed with an MD viewer.

@author: mike schrempp
6/17/2021
'''

import os
import sys


help = '''This python script looks through the input gcode file for lines with comments
that begin with "!". It strips off any characters preceeding the comment, and also the ":!

Then it saves these lines into a file of the same name but with an "md file extension.
The script is intnded to be run form the directory where the target files are located. 


command line variables

-h       prints this help message

-f       input file to be parsed

-a       Parse all files in the current directory

'''

##########################################
## PARSE COMMAND LINE VARIALBLES
parse_all_files = False

if len(sys.argv)==1: # It means no input arguments given.
	print(help)
	exit()
else:
	args = sys.argv
	i=1
	while i < len(args):
		if  args[i].lower in ("-h","-?","h","?","HELP","H","help"): 
			print(help)
			exit()
		elif args[i] in ("-file", "file", "-F", "f", "F", "-f") :
			i = i + 1
			file_to_parse = args[i]
			i = i + 1
		elif args[i] in ("-a", "a", "-A", "A", "ALL", "all", 'All') :
			parse_all_files = True
			i = i + 1
		else:
			print("Unknown command line variable: [" + str(args[i]) + "]. Exiting script.\n")
			print(help)
			exit()


##########################################
## SOME HOUSEKEEPING STUFF


##########################################
## LETS GET GOING WITH THE REAL WORK!

files_to_parse = []

if parse_all_files:
	# get list of files in this directory
	for object in os.listdir():
		if os.path.isfile(object):
			#Only keep files with a "gcode" extension 
			if object.split(".")[-1] == "gcode":
				files_to_parse.append(object)

else:
	files_to_parse.append(file_to_parse)
	
if len(files_to_parse) ==0:
	print("No parsable files found. Exiting")
	exit()
else:
	print("About to create "+str(len(files_to_parse)) +" MD files from gcode fles.")

for file in files_to_parse:
	# sort out gcode files
	print("Starting to parse file: "+file)
	
	# Create the output file
	output_filename  = ".".join(file.split(".")[0:-1]) + ".md"
	
	# Open the file and write a header message into it.
	with open(output_filename, 'w') as outfile:
		outfile.write("*this is an auto-generated md file for the **"+ str(file) + \
		              "** gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*\n")
	
		# Now let's open the gcode file and look for comments on each line
		with open(file, 'r') as my_file:
			
			for this_line in my_file:
			
				# Look for the character combo that measn we should put the line in the output file
				if ";!" in this_line:
					this_line = ";!".join(this_line.split(";!")[1:])
					outfile.write(this_line)
		
	print("Finished creating file: "+output_filename)
	
print ("Finished creating all files")




