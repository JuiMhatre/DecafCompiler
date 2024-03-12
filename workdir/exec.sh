if [ $# -eq 0 ]; then
    echo "Usage: $0 <output_file>"
    exit 1
fi

# Run a.out and redirect output to the given output file
./a.out > "$1"