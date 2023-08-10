#this command can be run on the Unix and Linux operating system terminals

# I take the output file name without any extension  to remove any duplicity of output file_name

#this line of code ensures that you passed at least one param in the terminal otherwise it will fall in the if block and the program terminates
if [ $# -lt 1 ]; then
    echo "Pass Require Params i.e Output File Name"
    exit 1
fi
output_file_name="$1"

#checking if the output file name already exists in the directory or not

if [ -e "${output_file_name}.log" ]; then
    echo "The output file name '${output_file_name}.log' already exists on the directory."
    exit 1
fi
	
#Here comes the main command to find the largest file name, not directory by the fixed extension i.e .log
#It searches and returns the largest log in four parts
#$(find / -name "*.log" -type f -exec du -h {} + 2>/dev/null This part of the code finds the largest log file with its current memory acquired in the disk
#sort -rh line sort the files in the descending order
# head -n 1 picks the topmost file 
#currently the largest_log name consists of the file name+memory size so to cut that we need to remove the second col val after that we will get the original file name
#2>/dev/null suppress all the potential errors in the code and focus on the output
largest_log_file_name=$(find / -name "*.log" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 1 | cut -f2-)

#if the files by extension do not exist then it displays this message
if [ -z "$largest_log_file_name" ]; then
    echo "No log files found on the Computer."
    exit 1
fi

#otherwise it truncates log files to 100 lines and puts that into the user input file name

head -n 100 "$largest_log_file_name" > $output_file_name.log
echo "Truncation Activity is Successfully finished from the largest log file found on the computer, truncated to 100 lines, and saved as.$output_file_name.log."

