#!/bin/bash

# ****************************************
# 1. BASIC OUTPUT
echo "Hello World!"

# ****************************************
# 2. VARIABLES
name="Glen Correia" # notice that there can be no space before and after the = sign
greeting="Hi there"

echo $name
echo ${name} # wrapping the variable name between curly brackets is not required, but is considered a good practice

# ****************************************
# 3. INTERPOLATION
echo "$greeting dear $name"

# ****************************************
# 4. ACCEPTING ARGUMENTS FROM COMMAND LINE
echo "Hello there" $1 # $1 is the first parameter
echo "Hello there" $2 # $2 is the second parameter
echo "Hello there" $@ # $@ is for all parameters

# ****************************************
# 5. BASH USER INPUT
echo "What is your name?"
read name

echo "Hi there $name"
echo "Welcome to Earth!"

# Shorter code
read -p "What is your name? " name
echo "Hi there $name"
echo "Welcome to Earth!"

# ****************************************
# 6. BASH ARGUMENTS
echo "Argument 1 is " $1
echo "Argument 2 is " $2
echo "Argument 3 is " $3

echo "All the arguments " $@

# $0 is used to reference the script itself. This is an exellent way to create self destruct the file if you need to or just get the name of the script.
# echo "The name of the file is: $0 and it is going to be self deleted."
# rm -f $0

# ****************************************
# 7. BASH ARRAYS
my_array=("value 1" "value 2" "value 3" "value 4")
echo ${my_array[1]} # outputs 'value 2'
# echo ${my_array[-1]} # outputs the last element of the array
echo ${my_array[@]} 
echo ${#my_array[@]} # prepending the array with a hash sign (#) would output the total number of elements in the array, in our case it is 4

# ****************************************
# 8. ARRAY SLICING
array=("A", "B", "C", "D", "E")
echo "${array[@]}" # print the entire array
echo "${array[1]}" # access a single element
echo "${array[@]:1:3}" # print a range of elements
echo "${array[@]:3}" # print from an index to the end

# ****************************************
# 9. STRING SLICING
# basic syntax - ${string:start:length}
text="ABCDE"
echo "${text:0:2}" # extract from index 0, maximum 2 characters
echo "${text:3}" # extract from index 3 to the end
echo "${text:1:3}" # extract 3 characters starting from index 1
echo "${text:3:3}" # if length exceeds remaining characters, it stops at the end.
text="Hello, World!"
echo "${text:7:5}" # outputs World
echo "${text:7:10}" # outputs World!

# ****************************************
# 10. BASH CONDITIONAL EXPRESSIONS
# FILE EXPRESSIONS
[[ -a ${file} ]] # true if file exists
[[ -b ${file} ]] # true if file exists and is a block special file
[[ -c ${file} ]] # true if file exists and is a character special file
[[ -d ${file} ]] # true if file exists and is a directory
[[ -e ${file} ]] # true if file exists
[[ -f ${file} ]] # true if file exists and is a regular file
[[ -h ${file} ]] # true if file exists and is a symbolic link
[[ -r ${file} ]] # true if file exists and is a readable file
[[ -s ${file} ]] # true if file exists and has a size greater than zero
[[ -w ${file} ]] # true if file exists and is writable
[[ -x ${file} ]] # true if file exists and is executable
[[ -L ${file} ]] # true if file exists and is a symbolic file

# STRING EXPRESSIONS
[[ -v ${varname} ]] # true if the shell variable varname is set (has been assigned a value)
[[ -z ${string} ]] # true if the length of the string is zero
[[ -n ${string} ]] # true if the length of the string is non-zero
[[ ${string1} == ${string2} ]] # true if the strings are equal. = should be used with the test command for POSIX conformance.
[[ ${string1} != ${string2} ]] # true if the strings are not equal
[[ ${string1} < ${string2} ]] # true if string1 sorts before string2 lexicographically
[[ ${string1} > ${string2} ]] # true if string1 sorts after string2 lexicographically

# ARITHMETIC OPERATORS
[[ ${arg1} -eq ${arg2} ]] # returns true if the numbers are equal
[[ ${arg1} -ne ${arg2} ]] # returns true if the numbers are not equal
[[ ${arg1} -lt ${arg2} ]] # returns true if arg1 is less than arg2
[[ ${arg1} -le ${arg2} ]] # returns true if arg1 is less than or equal to arg2
[[ ${arg1} -gt ${arg2} ]] # returns true if arg1 is greater than arg2
[[ ${arg1} -ge ${arg2} ]] # returns true if arg1 is greater than or equal to arg2
# As with other programming languages you can use AND & OR conditions
[[ test_case_1 ]] && [[ test_case_2 ]] # And
[[ test_case_1 ]] || [[ test_case_2 ]] # Or

# EXIT STATE OPERATORS
[[ $? -eq 0 ]] # returns true if the command was successful without any errors
[[ $? -gt 0 ]] # returns true if the command was not successful or had errors

# ****************************************
# 11. BASH CONDITIONALS
# IF STATEMENT (basic syntax)
if [[ some_test ]]
then
    <commmand>
fi

echo "What is your name?"
read name

if [[ -z ${name} ]]
then
    echo "Please enter your name!"
fi

# IF ELSE STATEMENT
read -p "What is your name?" name

if [[ -z ${name} ]]
then
    echo "Please enter your name!"
else
    echo "Hi there ${name}"
fi

# another example
admin="glenc"
read -p "Enter your username? " username

if [[ "${username}" == "${admin}" ]] ; then
    echo "You are the admin user!"
else
    echo "You are NOT the admin user!"
fi

# here is another example of an if statement which would check your current user ID and would not allow you to run the script as the root user
if (( $EUID == 0 )); then
    echo "Please do not run as root"
    exit 
fi
# to demonstrate the above example you can run $sudo ./start.sh

# OR OPERATOR
admin="kalel"
read -p "Enter your username? " username
# Check if the username provided is the admin

if [[ "${username}" != "${admin}" ]] || [[ $EUID != 0 ]] ; then
    echo "You are not the admin or root user, but please be safe!"
else
    echo "You are the admin user! This could be very destructive!"
fi

# ELIF STATEMENT
read -p "Enter a number: " num
if [[ $num -gt 0 ]] ; then
    echo "The number is positive"
elif [[ $num -lt 0 ]] ; then
    echo "The number is negative"
else
    echo "The number is 0"
fi

# SWITCH STATEMENT (basic syntax)
case $some_variable in

    pattern 1) 
      commands
      ;;
    
    pattern 2 | pattern 3)
      commands
      ;;
    *)
      default commands
      ;;
    esac

# Example
read -p "Enter the name of your car brand: " car

case $car in
    Tesla)
        echo -n "${car}'s car factory is in USA."
        ;;
    BMW | Mercedes | Audi | Porsche)
        echo -n "${car}'s car factory is in Germany."
        ;;
    Toyota | Mazda | Mitsubishi | Subaru)
        echo -n "${car}'s car factory is in Japan."
        ;;
    *)
    echo -n "${car} is an unknown car brand"
    ;;
esac

# ****************************************
# 12. BASH LOOPS

# FOR LOOP (basic syntax)

for var in ${list}
do 
    your_commands
done 

# Example
users="devdojo glen tony"
for user in ${users}
do 
    echo "${user}"
done

# Another example
for num in {1..10}
do 
    echo ${num}
done

# WHILE LOOP (basic syntax)
while [ your_condition ]
do 
    your_commands
done

# Example
counter=1
while [[ $counter -le 10 ]]
do 
    echo $counter
    ((counter++))
done

# Example 2
read -p "What is your name? " name
while [[ -z $name ]]
do 
    echo "Your name cannot be blank. Please enter a valid name!"
    read -p "Enter your name again " name
done
echo "Hi there $name"

# UNTIL LOOP (basic syntax)
until [[ your_condition ]]
do 
    your_commands
done

# Example
count=1
until [[ $count -gt 10 ]]
do 
    echo $count
    ((count++))
done

# CONTINUE AND BREAK
# As with other languages, you can use continue and break with your bash scripts as well. Continue tells your
# bash script to stop the current iteration of the loop and start the next iteration.

# Example
for i in 1 2 3 4 5
do 
    if [[ $i -eq 2 ]]
    then 
        echo "skipping number 2"
        continue
    fi 
    echo "i is equal to $i"
done

# Break tells your bash script to end the loop stright away.
# Example
num=1
while [[ $num -lt 10 ]]
do
    if [[ $num -eq 5 ]]
    then 
        break
    fi
    echo "We reached $num"
    ((num++))
done
echo "Loop completed"

# Example of break command in nested loops
for (( a = 1; a < 10; a++ ))
do
    echo "outer loop: $a"
    for (( b = 1; b < 100; b++ ))
    do
        if [[ $b -gt 5 ]] 
        then
            break 2
        fi
        echo "Inner loop: $b "
    done
done

# ****************************************
# 12. BASH FUNCTIONS

function function_name() {
    your_commands
}

# You can also omit the function keyword at the beginning
function_name() {
    your_commands
}

# Example
hello() {
    echo "Hello World Function!"
}

hello # function call

# Passing arguments to a function
function hello() {
    echo "Hello $1!"
}

hello GlenCorreia

# ****************************************
# 13. DEBUGGING, TESTING, SHORTCUTS

# In order to debug your bash scripts, you can use -x when executing your scripts.
# bash -x ./your_script.sh
# Another way to test your scripts is to use this fantastic tool here -  https://www.shellcheck.net/

# Following are some shortcuts to help with the terminal
# ctrl + k # delete everything from the cursor to the end of the line.
# ctrl + u # delete everything from the cursor to the start of the line.
# ctrl + w # delete one word backward from the cursor.
# ctrl + r # search your history backward. most useful.
# ctrl + l # clear the screen, I use this instead of typing the clear command:
# ctrl + s # stops the output to the screen.
# ctrl + q # enable the output to the screen in case the previously stopped by ctrl + s.
# ctrl + c # terminate the current command.
# ctrl + z # throw the current command to background.

# ****************************************
# 14. CREATING CUSTOM BASH COMMANDS

alias conn="echo 'Total connections on port 80 and 443:' ; netstat -plant | grep '80\|443' | grep -v LISTEN | wc -l"

# ****************************************
# 15. SCRIPT TO CHECK CURRENT DISK USAGE, CPU USAGE, RAM USAGE, KERNEL VERSION

# refer to status.sh script