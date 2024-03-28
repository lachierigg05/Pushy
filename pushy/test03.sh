#!/bin/dash

#pushy-log test suite

# Test 1 - Simple check for log of committed file
echo a > a
./pushy-init >/dev/null
./pushy-add a 
./pushy-commit -m "added a" >/dev/null

if [ "$(./pushy-log)" = "0 added a" ];
then
    echo "Test 1 - Passed" 
else 
    echo "Test 1 - Failed" 
    rm -r .pushy
    exit 1
fi 

# Test 2 - Remove a file and commit then check the log of the first commit 
rm a
./pushy-add a
./pushy-commit -m "removed a" >/dev/null

if [ "$(./pushy-log)" = "1 removed a
0 added a" ];
then
    echo "Test 2 - Passed" 
else 
    echo "Test 2 - Failed" 
    rm -r .pushy
    exit 1
fi 

# Test 3 - Check if log is empty when no commits have been made
rm -r .pushy
./pushy-init >/dev/null
echo a > a
./pushy-add a
if [ "$(./pushy-log)" = "" ];
then
    echo "Test 3 - Passed" 
else 
    echo "Test 3 - Failed" 
    rm -r .pushy
    exit 1
fi

# Test 4 - Check for multiple commits and in the correct order
rm -r .pushy
echo a > a
./pushy-init >/dev/null
./pushy-add a
./pushy-commit -m "added a" >/dev/null
echo b > b
./pushy-add b
./pushy-commit -m "added b" >/dev/null
echo c > c
./pushy-add c
./pushy-commit -m "added c" >/dev/null

if [ "$(./pushy-log)" = "2 added c
1 added b
0 added a" ];
then
    echo "Test 4 - Passed" 
else
    echo "Test 4 - Failed"
    rm -r .pushy
    exit 1
fi

echo
echo "pushy-log test suite passed successfully!"
rm -r .pushy a b c 2>/dev/null