#this command can be run on the unix and linux operating system terminals

#i take the output file name without any extension  to remove any duplicacy of file_name

#this line of code ensures that you passed atleast one param in the terminal otherwise it will fall in the if block and program terminates
if [ $# -lt 1 ]; then
    echo "Pass Require Params i.e Output File Name"
    exit 1
fi
output_file_name="$1"

#checking if the output file name already exist in the directory or not

if [ -e "${output_file_name}.log" ]; then
    echo "The output file name '${output_file_name}.log' already exists on the directory or not."
    exit 1
fi
	
#Here comes the main command to find the largest file name not directory by the fixed extension i.e .log
#It search and return the largetst log in three format
#$(find . -maxdepth 1 -name "*.log" -type f -exec du -h {} this part of code find the largest log file with its current memory acquired in the disk
#sort -rh line sort the files in the descending order
# head -n 1 picks the top most file 
#currently the largest_log name consist of the the file name+memory size so to cut that we need to remove the second col val after that we will get the original fil name
largest_log_file_name=$(find . -maxdepth 1 -name "*.log" -type f -exec du -h {} + | sort -rh | head -n 1|cut -f2-)

#if the files by extension not exist then it display this message
if [ -z "$largest_log_file_name" ]; then
    echo "No log files found in the directory."
    exit 1
fi

#otherwise it truncate log files to 100 lines and put that into the user input file name

head -n 100 "$largest_log_file_name" > $output_file_name.log
echo "Truncation Activity is Successfully finished in the current directory to 100 lines and saved as.$output_file_name.log."

