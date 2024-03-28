#!/bin/dash

#pushy-status test suite

# Test 1: Check for successful status of an empty repo
echo "hello" > hello.txt
./pushy-init >/dev/null
./pushy-add hello.txt >/dev/null
./pushy-rm --force hello.txt
expected_output=""

if output="$(./pushy-status)" && 
    output=$(echo "$output" | sed -E 's/^(test|pushy).*$//g') &&
    [ -z "$output" ]; then
    echo "Test 1: Passed"
    rm -r .pushy
else
    echo "Test 1: Failed"
    echo "\tExpected output: $expected_output"
    echo "\tActual output: $output"
    rm -r .pushy
fi

# Test 2: Check for status of a file added to the index with no commits
echo "hello" > hello.txt
./pushy-init >/dev/null
./pushy-add hello.txt >/dev/null
expected_output="hello.txt - added to index"

if output="$(./pushy-status)" && 
    output=$(echo "$output" | sed -E 's/^(test|pushy).*$//g') &&
    [ "$output" = "$expected_output" ]; then
    echo "Test 2: Passed"
    rm -r .pushy
else
    echo "Test 2: Failed"
    echo "\tExpected output: $expected_output"
    echo "\tActual output: $output"
    rm -r .pushy
fi

# Test 3: Check for status of a file added to the index and committed with no current changes
echo "hello" > hello.txt
./pushy-init >/dev/null
./pushy-add hello.txt >/dev/null
./pushy-commit -m "hello.txt added" >/dev/null
expected_output="hello.txt - same as repo"

if output="$(./pushy-status)" && 
output=$(echo "$output" | sed -E 's/^(test|pushy).*$//g') &&
[ "$output" = "$expected_output" ]; 
then
    echo "Test 3: Passed"
    rm -r .pushy
else
    echo "Test 3: Failed"
    echo "\tExpected output: $expected_output"
    echo "\tActual output: $output"
    rm -r .pushy
fi