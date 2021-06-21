#! /bin/python 3
''' 
This python script looks through the input gcode file for lines with comments
that begin with "!". It strips off any characters preceeding the comment, and also the ":!

Then it saves these lines into a file of the same name but with an "md file extension.

If the -md argument is used, or no arguments are used, it will do teh above and also 
update readme files in all directories and subdirectories with any summaries it finds in
the gcode files. 

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

If the -md argument is used, or no arguments are used, it will do the above and also 
update (or create) a readme.md file in each directories and subdirectory with any 
summaries it finds in the gcode files. These will appear at the end of the readme.md file, 
each in heading level three section titled with the filename. 

The start of a summary is indicated in the code files as a comment 
starting with ';!<summary>'. The end of the summary is one of three things: '/summary>',
a new line that does not start with ';!', or EOF. if a file contains multiple summary fields, 
only the first summary field is used.  


command line variables

<none>   same as -md

-h       prints this help message

-f       input file to be parsed

-a       Parse all files in the current directory and subdirectories

-md      Parse all files in the current directory and create/update the readme.md to add the summary.

'''

##########################################
## PARSE COMMAND LINE VARIALBLES
parse_all_files = False

if len(sys.argv)==1: # It means no input arguments given.
	parse_all_files = True
	update_readme = True
else:
	args = sys.argv
	i=1
	while i < len(args):
		if  args[i].lower in ("-h","-?","h","?","HELP","H","help"): 
			print(help)
			exit()
		elif args[i] in ("-file", "file", "-F", "f", "F", "-f") :
			i = i + 1
			files_to_parse = [args[i]]
			i = i + 1
		elif args[i] in ("-a", "a", "-A", "A", "ALL", "all", 'All') :
			parse_all_files = True
			i = i + 1
		elif args[i] in ("-md", "md", "-MD", "MD") :
			parse_all_files = True
			update_readme = True
			print("will update readme")
			i=i+1
		else:
			print("Unknown command line variable: [" + str(args[i]) + "]. Exiting script.\n")
			print(help)
			exit()


##########################################
## FUNCTIONS AND HOUSEKEEPING STUFF

# a function to recurively collect directories and file names
def dir_to_list(starting_directory = os.getcwd(), prefix = "", numtabs =0, skip = ""):
	#print (numtabs*"\t"+"about to parse: " + starting_directory+ " with this prefix: ",prefix)
	return_list = []
	for object in os.listdir(starting_directory):
		#print(numtabs*"\t"+" about to test this object", os.path.join(prefix,object))
		if object in skip: continue
		if os.path.isdir(os.path.join(prefix,object)):
			new_prefix = os.path.join(prefix,object)
			#print(numtabs*"\t"+"  following: " + new_prefix)
			results_from_this_dir = dir_to_list(starting_directory = new_prefix, prefix =new_prefix, numtabs=numtabs+1)
			return_list += results_from_this_dir 
		elif os.path.isfile(os.path.join(prefix,object)):
			return_list.append(os.path.join(prefix,object))
			#print (numtabs*"\t"+"  file: ",os.path.join(prefix,object))
	return return_list
	
def debug_pause():
	response = input("Enter 'n' to stop:  ")
	if response in ("n","N", "no", "NO", "No"): exit()
	return
			




##########################################
## LETS GET GOING WITH THE REAL WORK!

print( 3*"\n"+"Starting md extraction process")
#Make a list of files to parse
if parse_all_files:
	#Get all the files in this and all subdirectories
	files_to_parse = dir_to_list(skip = ['www'])
	
	# scan the list and remove those that are not gcode files
	cleaned_files_to_parse = []
	for file in files_to_parse:
		if file.split(".")[-1] in ("gcode","G","g","Gcode","GCODE"):
			cleaned_files_to_parse.append(file)
	files_to_parse = cleaned_files_to_parse

if len(files_to_parse) == 0:
	print("No parsable files found. Exiting")
	exit()
else:
	print("About to create "+str(len(files_to_parse)) +" MD files from gcode fles.")
	#print(sorted(files_to_parse))
	#debug_pause()
	
			

			
# OK, now we have a list of the gcode files (including path from the current directory), we can proceed to process each one. 

for file in sorted(files_to_parse):
	path_to_file = os.path.split(file)[0]
	filename =  os.path.split(file)[1]


	# If the -md flag was set, or no flags were set, create a readme.md file in this directory if one does not esixt
	if update_readme:
		# if the readme file does not exist, create it.
		path_to_readme = os.path.join(path_to_file,"readme.md")
		if not os.path.exists(path_to_readme):
			print ("Creating readme in: " + path_to_file)
			with open(path_to_readme, 'w') as readme:
				readme_boilerplate =  "# " + path_to_file + " directory\n" +\
									"The gcode files in this directory and the sumamries from their comments (if available) are listed below.\n\n"
				readme.write(readme_boilerplate)
				
				
	# Let's get going on those gcode files
	print("Starting to parse file: "+file)
	
	# create a place to hold the summary (if there is one)
	summary = ""

	# Create the output file
	output_filename  = ".".join(file.split(".")[0:-1]) + ".md"
	

	# Let's make the md file for this thing first
	with open(output_filename, 'w') as outfile:
		outfile.write("*this is an auto-generated md file for the **"+ str(file) + \
		              "**  *gcode file. All comments in the original file with a '!' immediately following the ';' are collected here.*\n")
	
		# Now let's open the gcode file and look for comments on each line
		with open(file, 'r') as my_file:
			summary_started = False
			summary = "No summary found in the gcode comments in this file."
			for this_line in my_file:
				# Look for the character combo that measn we should put the line in the output file
				if ";!" in this_line:
					this_line = ";!".join(this_line.split(";!")[1:])
					outfile.write(this_line)
					
					# look for summary start tag in the comment
					if this_line.startswith("<SUMMARY>") or \
					   this_line.startswith("<summary>") or \
					   this_line.startswith("<Summary>"):
						summary_started = True
						summary_ended = False
						summary_beginning = this_line[9:]
						if "</SUMMARY>" in summary_beginning or \
						   "</summary>" in summary_beginning or \
						   "</Summary>" in summary_beginning:
							summary = summary_beginning.split("</SUMMARY>")[0].split("</summary>")[0].split("</Summary>")[0]
							summary_ended = True
						else: summary = summary_beginning
					elif summary_started and not summary_ended:
						if "</SUMMARY>" in this_line or \
						   "</summary>" in this_line or \
						   "</Summary>" in this_line:
							summary += this_line.split("</SUMMARY>")[0].split("</summary>")[0].split("</Summary>")[0]
							summary_ended = True
						else: summary += this_line
				elif summary_started:
					summary_ended = True
			
		# Now we have written the md file and have collected the summary (if there is one)
		# Time to place it in the readme.md in this folder.
		newfile= ""
		summary_placed = False
		
		
		with open(path_to_readme, 'r') as readme:
			#have_not_found_any_h3_headers = True
			for this_line in readme: # read the existing file line by line and put them in the newfile until an H3 header is found.
				#print(this_line, filename)
				#if line is not an h3 header:
				while not this_line.startswith("###"): # as long as we haven't found an H3 header, keep adding the lines to the newfile variable
					newfile += this_line
					this_line = readme.readline()
					if this_line == "": #we reached the EOF 
						if not summary_placed:  #  and didn't place the summary yet
							print("  Adding summaries to readme.md file - Got to EOF with no headers found.  Placing summary at end of file.")
							newfile += "### "+filename+ "\n"    # add the H3 header for this file
							newfile += summary  +"\n"     # add the summary for this file
							summary_placed = True
							break
					if this_line == "": break
				if this_line == "": break  # we reached EOF, so we are ready to exit this loop
				
					
			
				#If we got to here, we got to an H3 header line. Need to decide if it belongs before our summary,  
				# after it, or is an earlier version of our summary
			
				if this_line.replace("### ","").strip() < filename: # then we found a file name before us in aplhabetical order. keep going.
					print("  Adding summaries to readme.md file - found an earlier H3 header, continuing to process lines.")
					newfile += this_line
								
				elif this_line.replace("### ","").strip() > filename: #we found a filename after this one, so we need to place the summary before it
					if not summary_placed:
						print("  Adding summaries to readme.md file - found a later H3 header. Placing summary here before continuing to process lines.")
						newfile += "### "+filename+ "\n"    # add the H3 header for this file
						newfile += summary  +"\n"     # add the summary for this file
						summary_placed = True
				
				elif this_line.replace("### ","").strip() == filename: # we found an old version of this files summary, so we need to replace it
					print("  Adding summaries to readme.md file - found an older version of this summary. Replacing it")
					newfile += this_line
					newfile += summary  +"\n"     # add the summary for this file
					summary_placed = True
					
					#look for the next headerline or EOF without adding any of the lines 
					this_line = readme.readline()
					finished_dumping_old_summary_lines = False
					while this_line != "":
						this_line = readme.readline()
						if this_line.startswith("###"): # We found the start of the nese H3 section, stop skipping lines
							finished_dumping_old_summary_lines = True	
						if finished_dumping_old_summary_lines:
							newfile += this_line
						
					
	
		#Now we need to overwrite the existing file
		with open(path_to_readme, 'w') as readme:
			readme.write(newfile)
	
	print("Finished creating file: "+output_filename)
	
print ("Finished creating all files")




