# libp2p-perf-bench

The [iPerf](https://en.wikipedia.org/wiki/Iperf) equivalent for the libp2p
ecosystem.

In a nutshell a **client** sends as much data as possible through a single
multiplexed stream to a **server** which reads and discards all received data.
The client closes the stream after 10 seconds. Subsequently both the client and
the server print the result as the total number of bytes transferred and the
corresponding bandwidth on stdout.


## Implementations

- Golang

    - Transport: Tcp

    - Transport security: Noise or Plaintext

    - Multiplexing: Yamux

- Rust

    - Transport: Tcp

    - Transport security: Noise or Plaintext

    - Multiplexing: Yamux


## Getting started

```bash
$ make clean

#if you want you can make a new key pair
$ rm rust/test.pk8
$ make rust/test.pk8

#And finally build rust/go client and server
$ make


$ ./run.sh

# Start Rust and Golang servers.

# Rust -> Rust

## Transport security noise
Interval	Transfer	Bandwidth
0 s - 10.00 s	11088 MBytes	8870.34 MBit/s

## Transport security plaintext
Interval	Transfer	Bandwidth
0 s - 10.00 s	33133 MBytes	26506.40 MBit/s

# Rust -> Golang

## Transport security noise
Interval	Transfer	Bandwidth
0 s - 10.00 s	7375 MBytes	5899.94 MBit/s

## Transport security plaintext
Interval	Transfer	Bandwidth
0 s - 10.00 s	32453 MBytes	25962.27 MBit/s

# Golang -> Rust

## Transport security noise
Interval 	Transfer	Bandwidth
0s - 10.00 s 	7541 MBytes	6032.64 MBit/s

## Transport security plaintext
Interval 	Transfer	Bandwidth
0s - 10.00 s 	55181 MBytes	44144.62 MBit/s

# Golang -> Golang

## Transport security noise
Interval 	Transfer	Bandwidth
0s - 10.00 s 	6223 MBytes	4978.17 MBit/s

## Transport security plaintext
Interval 	Transfer	Bandwidth
0s - 10.00 s 	90379 MBytes	72303.12 MBit/s

$ sysctl -n machdep.cpu.brand_string
Apple M2
```


## License

Licensed under either of

 * MIT license - <http://opensource.org/licenses/MIT>
 * Apache License, Version 2.0 - <http://www.apache.org/licenses/LICENSE-2.0>

at your option.
