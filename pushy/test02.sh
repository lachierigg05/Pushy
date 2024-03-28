#!/bin/dash

# pushy-commit test suite

# Test 1: Check if updated files get copied into repo after
echo "hello" >> hello.txt
./pushy-init >/dev/null
./pushy-add "hello.txt" >/dev/null
./pushy-commit -m "Hello.txt added" >/dev/null

if [ ! -f ".pushy/hello.txt" ]; 
then 
    echo "Test 1: Failed: Check if updated files get copied into repo after: File not copied to repo"
    rm .pushy 2>/dev/null
    exit 1
fi

echo "Test 1: Passed"


# Test 2: Checks that updated files are added to new commit folder
if [ ! -f ".pushy/commits/0/hello.txt" ]; 
then 
    echo "Test 2: Failed: Check if updated files get copied into repo after: File not copied to repo"
    rm .pushy 2>/dev/null
    exit 1
fi

echo "Test 2: Passed"

# Test 3: Checks for failed commit error due to unadded files in index
./pushy-add "notReal.txt" >/dev/null
commit_exit_status="$?"
./pushy-commit -m "notReal.txt added" >/dev/null

if [ "$commit_exit_status" = 0 ]; 
then 
    echo "Test 3: Failed: Exit status was successful when a non-existent file was added and committed."
    rm .pushy 2>/dev/null
    exit 1
fi

echo "Test 3: Passed (Exit status $commit_exit_status)" 

# Test 4: Checks for removed files within a commit are properly removed from the repo and index
rm "hello.txt"
./pushy-add "hello.txt" >/dev/null
./pushy-commit -m "hello.txt removed" >/dev/null 

if [ -f .pushy/hello.txt ] || [ -f .pushy/index/hello.txt ];
then
    echo "Test 4: Failed - File was not removed correctly from both repo and directory" 
    exit 1
fi

echo "Test 4: Passed"

rm -R .pushy 2>/dev/null
echo
echo "pushy-commit test suite passed successfully!"

