# Proof that a ciphertext encrypts zero

## [Source code](https://github.com/ZenGo-X/zk-paillier/blob/master/src/zkproofs/zero_enc_proof.rs)

## Rationale

The proof allows a prover to prove that a ciphertext is an encryption of zero.

It is taken from DJ01 [https://www.brics.dk/RS/00/45/BRICS-RS-00-45.pdf](https://www.brics.dk/RS/00/45/BRICS-RS-00-45.pdf)
protocol for n^s power for s=1.

Both P and V know a ciphertext c. P knows randomness r such that \\( c \equiv r^n \pmod{n^2} \\)

The protocol:

1. P chooses a random r' and computes \\( a=r'^n \pmod{n^2} \\)
2. P computes \\( z=r' \* r^e \pmod{n^2} \\)  (e is the verifier challenge)
3. V checks that \\( z^n=a \* c^e \pmod{n^2} \\)

## Bug fix

The implementation of ZenGo X: zk-paillier has a bug, when prover set r' as zero, the ciphertext can be arbitary number.

Fix it: the verifier should check that 'a' is not zero.

## Latest commit when write this article

[https://github.com/ZenGo-X/zk-paillier/commit/6ffbef0debd67f4c09d1732d409efd8a084a46bd](https://github.com/ZenGo-X/zk-paillier/commit/6ffbef0debd67f4c09d1732d409efd8a084a46bd)
