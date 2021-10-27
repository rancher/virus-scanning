#!/bin/bash

expected_results=(
    'eicar.com.txt: Win.Test.EICAR_HDB-1 FOUND'
    'eicar-99.tar: Win.Test.EICAR_HDB-1 FOUND'
    'eicar-100.tar: Heuristics.Limits.Exceeded FOUND'
)

for i in "${expected_results[@]}"; do
    grep -q "$i" infected.txt
    if [[ $? -ne 0 ]]; then
        echo "Expected "$i" in output"
        exit 1
    fi
done

echo 'All tests completed successfully'
exit 0
