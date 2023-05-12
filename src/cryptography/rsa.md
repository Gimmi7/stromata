# RSA

RSA (Rivest–Shamir–Adleman), is a public-key cryptography.

## RSA trap door

In the case of RSA, the easy algorithm multiplies two prime numbers. If multiplication is the easy algorithm, its difficult pair algorithm is factoring the product of the multiplication into its two component primes.

## RAS max

In RSA, this maximum value (call it max) is obtained by multiplying two random prime numbers. The public and private keys are two specially chosen numbers that are greater than zero and less than the maximum value, call them pub and priv.

## RSA encrypt

To encrypt a number you multiply it by itself pub times, making sure to wrap around when you hit the maximum.

## RSA decrypt

To decrypt a message, you multiply it by itself priv times and you get back to the original number.

## derivation process

\\( p,q \\) : two  random  secret  primes. \
\\( n=p\times q \\) : n is RSA max. \
\\( d_A \\) ： random number such that \\( 1<d_A<n-1 \\), the priv key. \
\\( Q_a: d_A\times Q_a \equiv 1 \pmod{n} \\), the pub key.    \

encrypt: \\( E_m= m^{Q_a} \pmod{n} \\)     \

and encryptedMsg \\( E(m) \\) is decrypted via    \
\\( D_m= (E_m)^{d_A} \pmod{n} \\)    \

as \\( d_A \times Q_a=1 \\)  \
so \\( D_m=(m^{Q_a})^{d_A}=m^{Q_a*d_A}=m^1=m \\)   \

## RSA is not an ideal system for the future of cryptography

The gap between the difficulty of factoring large numbers and multiplying large numbers is shrinking as the number (i.e. the key's bit length) gets larger. As the resources available to decrypt numbers increase, the size of the keys need to grow even faster. This is not a sustainable situation for mobile and low-powered devices that have limited computational power. The gap between factoring and multiplying is not sustainable in the long term.

## RSA public key security

RSA public key often denoted as \\( (N,e) \\), N is the max value, e is exponent(denoted as \\(Q_a\\) above).

It is necessary to ensure that the public key defines a permutation over \\( Z_N \\): that is raising to the power of e modulo N must be bijective, or equivalently, every integer between \\([0, N-1]\\)  must hava an \\( e_{th} \\) root modulo N.

\\[ i^e \equiv y_i \bmod{N}, \quad  i \in [0,N-1], \quad y_i \in [0, N-1] \\]

## References

* [Efficient Noninteractive Certification of RSA Moduli and Beyond](https://eprint.iacr.org/2018/057.pdf)
