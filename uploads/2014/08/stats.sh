#!/bin/bash

function print_usage {
	echo "Usage: $0 FILE ..." 
}

if [ "$#" -lt 1 ]; then
	print_usage;
	exit 1;
fi

files="$*"

# word counts
words=$(wc -w $files)
numposts=$(ls -1 $files | wc -l)
totalwords=$(echo -e "$words" | grep total | tr -s ' ' | sed -e 's/^ //g' | cut -d ' ' -f1)
words=$(echo -e "$words" | grep -v total | sort -n) # leave out total

mean=$(echo "scale=1; $totalwords / $numposts" | bc)
min=$(echo -e "$words" | head -n 1 | tr -s ' ')
max=$(echo -e "$words" | tail -n 1 | tr -s ' ')

echo "Number of posts: $numposts"

echo "Word count:"
echo "Total: $totalwords"
echo "Min: $min"
echo "Max: $max"
echo "Mean: $mean"

s=0
IFS=$'\n'
for w in $words; do
	current=$(echo $w | tr -s ' ' | cut -d ' ' -f2)
	s=$(echo "scale=1; $s + ($current - $mean) ^ 2" | bc)
done

stddev=$(echo "scale=1; sqrt ($s/$numposts)" | bc)
echo "Stddev: $stddev"

# word frequencies
IFS=$' '
cat $files | sed -e 's/[^a-zA-Z ]//g' | tr '[:upper:]' '[:lower:]' | tr ' ' '\n' | sort | uniq -c | awk '{print $1,$2;}' | sort -n > /tmp/freqs

# This one's case sensitive
#cat $files | sed -e 's/[^a-zA-Z ]//g' | tr ' ' '\n' | sort | uniq -c | awk '{print $1,$2;}' | sort -n > /tmp/freqs
