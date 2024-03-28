#!/bin/dash

#pushy-rm test suite 

# Test 1: Check for successful removal of file from repo
echo "hello" > hello.txt
./pushy-init >/dev/null
./pushy-add hello.txt >/dev/null
./pushy-commit -m "hello.txt added" >/dev/null

if ./pushy-rm hello.txt && 
   [ ! -f hello.txt ] &&     
   [ ! -f .pushy/index/hello.txt ];  
then
    echo "Test 1: Passed"
else
    echo "Test 1: Failed" 
    exit 1
fi

# Test 2: Check for --cached flag to remove file from index only
echo "hello" > hello.txt
./pushy-add hello.txt >/dev/null
./pushy-commit -m "hello.txt added" >/dev/null

if ./pushy-rm --cached hello.txt && 
   [ -f hello.txt ] &&     
   [ ! -f .pushy/index/hello.txt ];  
then
    echo "Test 2: Passed"
else
    echo "Test 2: Failed" 
    exit 1
fi

# Test 3: Check for stoppage of removal of changed files from repo
echo "hello" > hello.txt
./pushy-add hello.txt >/dev/null
./pushy-commit -m "hello.txt added" >/dev/null
echo "goodbye" > hello.txt

if [ "$(./pushy-rm hello.txt)" = "./pushy-rm: error: 'hello.txt' in the repository is different to the working file" ]; 
then
    echo "Test 3: Passed"
    rm -r .pushy
else 
    echo "Test 3: Failed"
    echo "$output"
    rm -r .pushy
fi

# Test 4: Check for stoppage of removal of multiple changed files from repo
echo test > test.txt
./pushy-init >/dev/null
./pushy-add test.txt >/dev/null
./pushy-commit -m "test.txt added" >/dev/null
echo "changed test file" > test.txt
echo "hello" > hello.txt
./pushy-add hello.txt >/dev/null

expected_error="./pushy-rm: error: 'hello.txt' has staged changes in the index"

output=$(./pushy-rm hello.txt test.txt)

if [ "$output" = "$expected_error" ] && 
   [ -f test.txt ] && 
   [ -f .pushy/index/test.txt ] && 
   [ -f hello.txt ] && 
   [ -f .pushy/index/hello.txt ]; 
then
    echo "Test 4: Passed"
    rm -r .pushy
else 
    echo "Test 4: Failed"
    echo "Expected output: $expected_error"
    echo "Actual output: $output" 
    rm -r .pushy
fi

# Test 5: Check for stoppage of removal of multiple changed files from repo with --cached option
echo test > test.txt
./pushy-init >/dev/null
./pushy-add test.txt >/dev/null
./pushy-commit -m "test.txt added" >/dev/null
echo "changed test file" > test.txt
echo "hello" > hello.txt
./pushy-add hello.txt >/dev/null
echo "hello again" > hello.txt

expected_error="./pushy-rm: error: 'hello.txt' in index is different to both the working file and the repository"

output=$(./pushy-rm --cached hello.txt test.txt)

if [ "$output" = "$expected_error" ] && 
   [ -f test.txt ] && 
   [ -f .pushy/index/test.txt ] && 
   [ -f hello.txt ] && 
   [ -f .pushy/index/hello.txt ]; 
then
    echo "Test 5: Passed"
    rm -r .pushy
else 
    echo "Test 5: Failed"
    echo "\tExpected output: $expected_error"
    echo "\tActual output: $output" 
    rm -r .pushy
fi

# Test 6: Check force option bypasses error of changed files
echo test > test.txt
./pushy-init >/dev/null
./pushy-add test.txt >/dev/null
./pushy-commit -m "test.txt added" >/dev/null
echo "changed test file" > test.txt
echo "hello" > hello.txt
./pushy-add hello.txt >/dev/null
echo "hello again" > hello.txt

if ./pushy-rm --force hello.txt test.txt && 
   [ ! -f test.txt ] && 
   [ ! -f .pushy/index/test.txt ] && 
   [ ! -f hello.txt ] && 
   [ ! -f .pushy/index/hello.txt ]; 
then
    echo "Test 6: Passed"
    rm -r .pushy
else 
    echo "Test 6: Failed"
    rm -r .pushy
fi



