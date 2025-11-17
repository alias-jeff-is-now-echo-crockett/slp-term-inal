SLP DEFINE
A command-line helper for Speech-Language Pathology students preparing for the Praxis exam

SLP Define is a simple terminal command that lets you instantly look up anatomy and SLP-related terminology using Wikipedia’s summary API. Instead of opening a browser every time you forget what the omohyoid, nasal fricative, or superior laryngeal nerve does, you can type:

slpdefine omohyoid

and get back:

Human neck muscle

It is fast, lightweight, and designed to help you study more efficiently.

WHAT SLP DEFINE DOES

Looks up any anatomy or terminology term from Wikipedia

Prints the short “definition” or description line

Helps with rapid recall during Praxis exam study sessions

Runs entirely in your macOS terminal

Great for reviewing:

Speech and swallowing muscles

Cranial nerves

Phonetics and articulation terms

Voice and resonance structures

Neurological structures related to communication

REQUIREMENTS

To use slpdefine, you need the following installed on macOS:

Python 3
Most Macs already include this.
Check: python3 --version
If needed: brew install python

jq
A lightweight JSON parsing tool used to extract the Wikipedia description.
Install with: brew install jq

INSTALLATION

Open your terminal.

Edit your .zshrc file:
nano ~/.zshrc

Add the following function:

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

curl -s "https://en.wikipedia.org/api/rest_v1/page/summary/$encoded