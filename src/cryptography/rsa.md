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

## Derivation process

* $ p,q $ : distinct equal-length primes. Thus p will not divide q-1 and q will not divide p-1, which ensures that $gcd(N, \phi(N))=1 $
* $ n=p\times q $ : n is RSA max.
* $\lambda(n)=lcm(p-1,q-1) $  
* choose e: $ 2< e < \lambda(n), gcd(e,\lambda(n))=1 $  
* determine d: $d \equiv e^{-1} \pmod{\lambda(n)} $

encrypt: $ E_m= m^{e} \pmod{n} $    \

and encryptedMsg $ E(m) $ is decrypted via    \
$ D_m= (E_m)^{d} \pmod{n} $   \

$ D_m=(m^{e})^{d} \equiv m^{ed} \equiv m^{ed \bmod ord_n(m)} \equiv m^{ed \bmod \lambda(n)} \equiv m^1 \equiv  m \pmod{n} $   \

## RSA is not an ideal system for the future of cryptography

The gap between the difficulty of factoring large numbers and multiplying large numbers is shrinking as the number (i.e. the key's bit length) gets larger. As the resources available to decrypt numbers increase, the size of the keys need to grow even faster. This is not a sustainable situation for mobile and low-powered devices that have limited computational power. The gap between factoring and multiplying is not sustainable in the long term.

## RSA security

RSA security can be classify into 3 parts, each part is corresponding to **n,e,m,** (n,e) is the public key, m is the msg need to be encrypted.

* RSA n security: $gcd(n,\phi(n))=1 $, this condition ensure that $ (p \nmid q-1) and (q \nmid p-1) $, this help maintain the difficulty of factoring the modulus $n=pq $.
* RSA e security: $gcd(e, \phi(n))=1 $, ensure the map $x \mapsto x^e $ is a permutation over $Z_n^*$, if with the condition n is square-free, then the map $x \mapsto x^e $ is a permutation over $Z_n$.
* RSA m security: $gcd(m, n)=1$, there is a negligible possibility will leak the factorization of n. When msg m is not coprime to n, the encrypted result $m^e \pmod{n} $ is not coprime to n, then the factorization will be leaked ($factor=gcd(m^e \pmod{n}, n) $). The possibility $P=1-\frac{\phi(n)}{n} $， if n is not generated with bias, the possibility is trivial.

## RSA e security

RSA public key often denoted as $ (N,e) $, N is the max value, e is exponent.

It is necessary to ensure that the public key operation $[(msg)^e \bmod{n}] $ is a permutation over $Z_N $: that is raising to the power of e modulo N must be bijective, or equivalently, every integer between $[0, N-1] $  must hava an $ e_{th} $ root modulo N.

$$ i^e \equiv y_i \bmod{N}, \quad  i \in [0,N-1], \quad y_i \in [0, N-1] $$

If the map funtion is not a permutation over $Z_N$, then some element in $Z_N$ after map will get the same value (not injective), this will cause information loss.

## $x \mapsto x^e \pmod{N} $  permutation

$x \mapsto x^e \pmod{N} $ defines a permutation over $Z_N^*$ if and only if e is relative to $\phi(N) $
$$L_{permZ_N^*}=\{(N,e)|N,e>0 \ and \ gcd(e,\phi(N))=1\} $$

proof:

1. Suppose $gcd(e,\phi(N))=1 $, Then let $d=e^{-1} \pmod{\phi(N)} $ \
The map funtion is $x \mapsto x^e \pmod{n} $, and the inverse map is $y \mapsto y^d \pmod{n} $  \
Thus $de=1+k\phi(N) $ for some integer k.   \
$\forall x \in Z_N^*:$ \
$(x^e)^d \pmod{N} \equiv x^{1+k\phi(N)} \pmod{N} \equiv x \times (x^{\phi(N)})^k \pmod{N} \equiv x \pmod{N} $ \
Because x map to y, then y map to x, use the "same" funtion(exponent modulo), so the map function is a permutation.
2. Suppose $gcd(e, \phi(N))= d \not=1 $, Then $d| \phi(N) $ \
so exists a element $x \not=1 $ whose multiplicative order is d, $ x^d \equiv 1 \pmod{N} $  \
$x^e \pmod{N} \equiv (x^d)^{\frac{e}{d}} \pmod{N} \equiv 1 \pmod{N} $   \
so when $ gcd(e, \phi(N)) \not=1, x^e \equiv 1 \pmod{N}, x\in Z_N^* $

Furthermore, if N is also square free, $x \mapsto x^e \pmod{N} $ is a permuation over $Z_N$. \
A number N is **square free** if it can be written as $N = p_1p_2 \cdots p_r$ for distinct prime numbers
$p_i$ (N is not square free if it is divisible by $p^2$, where p is some prime.)

In [https://eprint.iacr.org/2018/057.pdf](https://eprint.iacr.org/2018/057.pdf) Theorem3.3, Lemma A.6, The author introduce a method that check N is not divisible by all the primes less than $\alpha $, The prof can provide statistical soundness with error $Probability= \frac{1}{\alpha^m} <= 2^{-\mathcal{k}} $

## RSA n security

$n=pq \\
\phi(n)=\phi(p)\phi(q)=(p-1)(q-1) \\
d \equiv e^{-1} \pmod{\phi(n)} \\
$
If $(p | q-1) or (q | p-1) $,  then $gcd(n, \phi(n))=d > 1$, it would imply that p and (q-1) share a common factor. In such a case ,the Euler's totient funtion value $\phi(n) $ would become more predictable, which could weaken the security of the RSA algorithm.

## References

* [Efficient Noninteractive Certification of RSA Moduli and Beyond](https://eprint.iacr.org/2018/057.pdf)
* [A Computational Introduction to Number Theory and Algebra](https://www.shoup.net/ntb/ntb-v2.pdf)
* [wiki: RSA key generation](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Key_generation)
* [Certifying RSA Public Keys with an Efficient NIZK](https://open.bu.edu/ds2/stream/?#/documents/238765/page/4)
