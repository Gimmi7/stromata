# Proof of knowledge of plaintext (correctness of ciphertext)

## [Source code](https://github.com/ZenGo-X/zk-paillier/blob/master/src/zkproofs/correct_ciphertext.rs)

## Rationale

 This proof shows that a paillier ciphertext was constructed correctly

 The proof is taken from <https://www.brics.dk/RS/00/14/BRICS-RS-00-14.pdf> 9.1.3

 Given a ciphertext c and a prover encryption key , a prover wants to prove that it knows (x,r) such that c = Enc(x,r)

 1. P picks x',r' at random, and computes c' = Enc(x', r')
 2. P computes \\( z_1 = x' + ex \\), \\( z_2 = r' *r^e \\) (e is a verifier challenge)
 3. P sends, \\( (c' , z_1, z_2) \\)
 4. V accepts if  \\( Enc(z_1,z_2 ) = c' * c^e \\)

## Bug fix

The implementation of ZenGo X: zk-paillier has a bug, when prover set r' as zero, the ciphertext can be arbitary number.

Fix it: the verifier should check that " c' " is not zero.

## Latest commit when write this article

[https://github.com/ZenGo-X/zk-paillier/commit/6ffbef0debd67f4c09d1732d409efd8a084a46bd](https://github.com/ZenGo-X/zk-paillier/commit/6ffbef0debd67f4c09d1732d409efd8a084a46bd)
