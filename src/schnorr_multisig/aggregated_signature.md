# Schnorr Aggregated signature

The aggregated signature is based on the work in [Compact Multi-Signatures for Smaller Blockchains](https://eprint.iacr.org/2018/483.pdf) section 5.1. This protocol is used to aggregate signatures of all counter parties.

## Key generation

* each party generate a random **x** as private key
* public key is: \\( \quad Q = x \cdot G \\)

## Public key aggregation

* aggregated public key hash \\( \overline{h_Q}= hash(Q_1,Q_2,\cdots,Q_n) \\)
* aggregated public key \\( \overline{Q}=\sum_{i=1}^n (\overline{h_Q} \cdot Q_i) \\)

## Signing

Signing is an interactive three-round protocol. singer i behaves as follows:

**[Round 1] generate r and R:**

* Choose random \\( r_i \\), and compute \\( R_i = r_i \cdot G \\)
* Calc \\( h_{R_i}= hash(R_i) \\)
* Send \\( h_{R_i} \\) to all other singers corresponding to \\( Q_1, Q_2,\cdots, Q_n \\) and wait to receive \\( h_{R_j} \\) from all other signers \\( j \not= i \\)

**[Round 2] broadcast and check R:**

* Send \\(R_i\\) to all other signers corresponding to \\( Q_1,Q_2,\cdots,Q_n \\) and wait to receive \\( R_j\\) from all other signers \\( j \not= i \\). Check that \\( h_{R_j}= hash(R_j) \\) for all \\( j=1,2,\cdots,n \\).

**[Round 3] :**

* Calc aggregated publick key \\( \overline{Q}=\sum_{i=1}^n (\overline{h_Q} \cdot Q_i) \\), when multiple messages are signed with the same set of signers, \\( \overline{Q}, \overline{h_Q} \\) can be stored.
* Calc aggregated point R: \\( \overline{R}=\sum_{i=1}^n R_i \\)
* Hash msg with public params: \\( h=hash(\overline{R}, \overline{Q}, msg) \\)
* Calc partial signature \\( s_i = r_i + h \cdot x_i \cdot \overline{h_Q} \\)
* Send \\( s_i \\) to all other signers and wait to receive \\( s_j \\) from all others signers \\( j \not= i \\).
* Calc final signature \\( s=\sum_{i=1}^{n} s_i \\)
* Output the final signature as \\( (\overline{R}, s) \\)

## Verification

* Hash msg with public params: \\( h=hash(\overline{R}, \overline{Q}, msg) \\)
* Check if: \\( \quad s \cdot G - h \cdot \overline{Q} =  \overline{R} \\)

## The correctless proof

* \\( s \cdot G= (s_1+s_2+\cdots+s_n) \cdot G = [\sum_{i=1}^n (r_i + h \cdot x_i \cdot \overline{h_Q})]\cdot G \\)
* \\( h \cdot \overline{Q} = h \cdot (\overline{h_Q} \cdot Q_1 + \overline{h_Q} \cdot Q_2 +\cdots+ \overline{h_Q} \cdot Q_n ) = h \overline{h_Q} x_1 G + h \overline{h_Q} x_2 G +\cdots+ h \overline{h_Q} x_n G \\)
* \\( \therefore \quad lhs=(r_1 + r_2 +\cdots+ r_n)G \\)
* \\( \because \quad \overline{R}=R_1+R_2+\cdots+R_n \\)
* lhs=rhs

## Rotate share

Assume we just have two party, then we can update the shares with equation  \
 \\( x_1'=x_1-r \bmod{n} \\)  \
  \\( x_2'=x_2+r \bmod{n} \\)

## References

* [Compact Multi-Signatures for Smaller Blockchains](https://eprint.iacr.org/2018/483.pdf)
* [ZenGo-X: Aggregated-Ed25519-Signatures](https://github.com/ZenGo-X/multi-party-eddsa/wiki/Aggregated-Ed25519-Signatures)
