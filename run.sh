#!/usr/bin/env bash
# exit immediately when a command fails
set -e
# only exit with zero if all commands of the pipeline exit successfully
set -o pipefail
# error on unset variables
set -u

# Make sure to kill all background tasks when exiting.
trap "kill 0" EXIT

TransportSecurityProtocols=( noise plaintext )

echo "# Start Rust and Golang servers."
./rust/target/release/server --private-key-pkcs8 rust/test.pk8 --listen-address /ip4/0.0.0.0/tcp/9992 > /dev/null 2>&1 &
./golang/go-libp2p-perf --fake-crypto-seed --listen-address /ip4/0.0.0.0/tcp/9993 --transport-security noise > /dev/null 2>&1 &
./golang/go-libp2p-perf --fake-crypto-seed --listen-address /ip4/0.0.0.0/tcp/9994 --transport-security plaintext > /dev/null 2>&1 &

sleep 1

echo
echo "# Rust -> Rust"
for Protocol in ${TransportSecurityProtocols[*]}
do
    echo
    echo "## Transport security $Protocol"
    ./rust/target/release/client --server-address /ip4/127.0.0.1/tcp/9992 --transport-security $Protocol
done

echo
echo "# Rust -> Golang"
echo
echo "## Transport security noise"
./rust/target/release/client --server-address /ip4/127.0.0.1/tcp/9993 --transport-security noise
echo
echo "## Transport security plaintext"
./rust/target/release/client --server-address /ip4/127.0.0.1/tcp/9994 --transport-security plaintext

echo
echo "# Golang -> Rust"
for Protocol in ${TransportSecurityProtocols[*]}
do
    echo
    echo "## Transport security $Protocol"
    ./golang/go-libp2p-perf --server-address /ip4/127.0.0.1/tcp/9992/p2p/QmbvLAFb3aYAgRXMrLJW436sJFtikBP8CJmiQZ8ozaG4uQ --transport-security $Protocol
done

echo
echo "# Golang -> Golang"
echo
echo "## Transport security noise"
./golang/go-libp2p-perf --server-address /ip4/127.0.0.1/tcp/9993/p2p/12D3KooWL3XJ9EMCyZvmmGXL2LMiVBtrVa2BuESsJiXkSj7333Jw --transport-security noise
echo
echo "## Transport security plaintext"
./golang/go-libp2p-perf --server-address /ip4/127.0.0.1/tcp/9994/p2p/12D3KooWL3XJ9EMCyZvmmGXL2LMiVBtrVa2BuESsJiXkSj7333Jw --transport-security plaintext

