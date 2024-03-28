#!/bin/dash

# Test 1: Successful Initialization
echo "hello" >> hello.txt
./pushy-init >/dev/null

if [ ! -d ".pushy" ]; 
then 
    echo "Failed: Test 1: Successful Initialization: Pushy repo was not initialized"
    rm .pushy hello.txt 2>/dev/null
    exit 1
fi

echo "Passed: Test 1: Successful Initialization"

# Test 2: Duplicate Repo Error
./pushy-init >/dev/null
if [ "$?" -eq 0 ]; 
then
    echo "Failed:  Test 2: Duplicate Repo Error: expected error: './pushy-init: error: .pushy already exists'"
    rm -R .pushy hello.txt
    exit 1 
fi

echo "Passed: Test 2: Duplicate Repo Error"

rm -R .pushy hello.txt 2>/dev/null

echo
echo "pushy-init test suite passed successfully!"
