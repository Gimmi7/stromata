# ZK

## Comparison of the most popular zkp systems

|                                       | SNARKs                     | STARKs                        | Bulletproofs    |
| ------------------------------------: | -------------------------: | ----------------------------: | --------------: |
| Algorithmic complexity: prover        | O(N * log(N))              | O(N * poly-log(N))            | O(N * log(N))   |
| Algorithmic complexity: verifier      | ~O(1)                      | O(poly-log(N))                | O(N)            |
| Communication complexity (proof size) | ~O(1)                      | O(poly-log(N))                | O(log(N))       |
| - size estimate for 1 TX              | Tx: 200 bytes, Key: 50 MB  | 45 kB                         | 1.5 kb          |
| - size estimate for 10.000 TX         | Tx: 200 bytes, Key: 500 GB | 135 kb                        | 2.5 kb          |
| Ethereum/EVM verification gas cost    | ~600k (Groth16)            | ~2.5M (estimate, no impl.)    | N/A             |
| Trusted setup required?               | YES :unamused:             | NO :smile:                    | NO :smile:      |
| Post-quantum secure                   | NO :unamused:              | YES :smile:                   | NO :unamused:   |
| Crypto assumptions                    | DLP + secure bilinear pairing :unamused:          | Collision resistant hashes :smile: | Discrete log :smirk: |

## References

* [matter-labs: Awesome zero knowledge proofs](https://github.com/matter-labs/awesome-zero-knowledge-proofs/tree/master)
* [ventali: Awesome Zero Knowledge](https://github.com/ventali/awesome-zk)
