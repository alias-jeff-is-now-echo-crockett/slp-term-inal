slpdefine() {
  if [ $# -lt 1 ]; then
    echo "Usage: slpdefine <term>"
    return 1
  fi

  encoded=$(python3 - << 'EOF' "$@"
import urllib.parse, sys
print(urllib.parse.quote(" ".join(sys.argv[1:])))
EOF
)

  curl -s "https://en.wikipedia.org/api/rest_v1/page/summary/$encoded" \
    | jq -r '
      "TITLE: " + (.title // "Unknown") + "\n" +
      "DEFINITION: " + (.description // "No short definition available") + "\n\n" +
      "SUMMARY:\n" + (.extract // "No extended summary available")'
}
