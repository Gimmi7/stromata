# Pedersen Proof

protocol for proving that Pedersen commitment c was constructed correctly which is the same as
proof of knowledge of (m,r) such that c = mG + rH.

witness: (m,r)  \
statement: c   \
The Relation R outputs 1 if c = mG + rH.

G is the generator point, H is another generator point of elliptic curves.

 **The protocol:**

* Prover chooses \\( A_1 = s_1\*G , A_2 = s_2\*H \\)  for random \\( s_1,s_2 \\)
* Prover calculates challenge \\( e = Hash(G,H,c,A_1,A_2) \\)
* Prover calculates \\( z_1  = s_1 + em, z_2 = s_2 + er \\)
* Prover sends \\( proof = {e, A_1,A_2,c, z_1,z_2} \\)
* Verifier checks that \\( z_1\*G + z_2\*H  = A_1 + A_2 + ec \\)

## The correctless proof

* \\( lhs= z_1G + z_2H = (s_1+em)G + (s_2+er)H \\)
* \\( rhs= A_1+A_2+ec = s_1G + s_2H + e(mG+rH) \\)
* check if lhs==rhs
