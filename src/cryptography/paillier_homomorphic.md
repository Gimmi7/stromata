# Homomorphic Encryption

Homomorphic encryption is a form of encryption that allows computations to be performed directly on ciphertext, without the need to first decrypt it. In other words, homomorphic encryption enables the computation of a funtion on encrypted data suce that the result of the computation is the encrypted form, which an then be decrypted to obtain the final reault.

There are to main types of homomorphic encryption:full homomorphic encryption(FHE) and partially homomorphic encryption(PHE). FHE enables arbitrary computations to be performed on ciphertexts, while PHE only allows a restricted set of computations to be performed, such as addition or multiplication.

## Prerequisite

### Euler`s totient function

Euler's totient function, denoted as \\( \phi(n) \\), is a mathematical funtion that counts the number of positive integers less than or equal to n that are relatively prime to n, i.e.,they have no common factors other than 1.(greatest common divisor: gcd(n,k)=1)

For example, if n=10, the integers less than or equal to 10 thar are relatively prime to 10 are 1,3,7,and 9.Therefor,\\( \phi(10)=4 \\).

### Carmichael's function

Carmicheal's function, denoted as \\( \lambda(n) \\) is a mathematical funtion that generalizes Euler's totient funtion \\( \phi(n) \\) and computes the smallest positive integer m such that \\( a^m\equiv 1\pmod{n} \\) for all integers a that are relatively prime to n.

For example: \\( \lambda(8)=2 \\), because {1,3,5,7} are coprime to 8, \\( (1,3,5,7)^2\equiv 1\pmod{8}\\)

### Carmichael's theorem

\\( | \mathbb{Z} |^\*_{n^2}= \phi(n^2)=n\phi(n) \\),

and that for any: \\( \omega \in \mathbb{Z}^\*_{n^2}  \\)

\\[
  \begin{cases}
  \omega^{\lambda} \equiv 1 \bmod n,  \\\\
  \omega^{n\lambda} \equiv 1 \bmod n^2,   \\\\
  \end{cases}
\\]

we will adapt \\( \lambda \\) instead of \\( \lambda(n) \\) for visual comfort.

### Composite number

A composite number(合数) is a positive integer that can be formed by multiplying two smaller positive integers.Equivalently,it is a positive integer that has at least one divisor other than 1 and itself. Every positive integer is composite, prime or the unit 1.

### Deciding Composite Residuosity(Trap door function of Paillier)

The decisional composite residuosity assumption(DCRA) states that given a composite n and an integer z, it is hard to decide whether z is an n-th residue modulo \\(n^2\\). i.e. whether there exists a y such that
\\[ z\equiv y^n \bmod(n^2) \\]

* The had problem: Deciding n-th composite residuosity! \
  \\( z\equiv y^n \pmod{n^2} \\)
* The set of n-th residues is a multiplicative subgroup of \\( Z^*_{n^2} \\) of order \
  \\( \phi(n) \\)
* Each n-th residue z has exactly n roots of degree n,among which examply one is strictly smaller that n, namely \
  \\( r \equiv \sqrt[n]{z} \pmod{n}, r \in Z^*_n \\)
* The n-th roots of unity are the numbers of the form \
  \\( (1+n)^m = 1+mn \pmod{n^2}, m \in Z_n \\)
* Generate the multiplicative subgroup \\( Z^*_{n^2} \\) as \
  \\( Z_n \times Z^\*_n \\)

## Paillier homomorphic encryption

**Setup:**

* Chose two large prime numbers \\({\color{Red}p}\\) and \\({\color{Red}q}\\) and form the modulus \
 \\(n=pq\\)
* Euler's totient funtion gives the number of relative prime elements in \\(Z^*_n\\)  \
  \\( \phi(n)=(p-1)(q-1) \\)
* The number of relative prime elements in \\(Z^*_{n^2}\\) is \
  \\( \phi(n^2)=n\phi(n) \\)
* The partial private key \\({\color{Red}\lambda}\\) is determined by Carmichael's funtion   \
  \\( \lambda(n)=lcm(p-1,q-1) \\), least common multiple(最小公倍数).
* the order of g is a nonzero multiple of n

**Paillier Encryption:**

\\[ (m,r) \rightarrow g^m \cdot r^n \pmod{n^2} =c \\]
m: plaintext message, r: random number for semantic security

**Paillier Decryptin:**

\\[ m=\frac{L(c^\lambda \bmod n^2 )}{ L(g^\lambda \bmod n^2)} \bmod n \\]
\\[ L(x)=\frac{x-1}{n} \\]

**Proof:**

\\( DEC(c)=\frac{L(c^\lambda \bmod n^2 )}{ L(g^\lambda \bmod n^2)} \bmod n \\)   \
\\( c^\lambda=(g^m \cdot r^n)^\lambda= g^{m\lambda} \cdot r^{n\lambda} \\)   \
accoording to Carmichael's theorem, we have:
\\[ r^{n\lambda}\equiv 1 \bmod n^2 \\]
\\( DEC(c)=\frac{L(g^{m\lambda} \bmod n^2)}{L(g^\lambda \bmod n^2)} \bmod n \\)     \
\\( \because g^\lambda \equiv 1 \pmod{n} \\) \
\\( \therefore g^\lambda = 1+kn \\)   \
\\( g^{m\lambda} \equiv (1+kn)^m \pmod{n^2} \equiv 1+knm \pmod{n^2} \\)     \
\\( DEC(c)= \frac{km}{k} =m \\)

## Additive Homomorphic Properties

\\( c_1=g^{m_1}r_1^n \\) \
\\( c_2=g^{m_2}r_2^n \\) \
\\( c_1 c_2=g^{m_1+m_2}(r_1 r_2)^n \\)

## Encrypted message multiple plain number

\\( c=g^m r^n \\) \
\\( c^k=g^{km}r^{kn} \\)

## References

* [Public-Key Cryptosystems Based on Composite Degree Residuosity Classes](https://link.springer.com/content/pdf/10.1007/3-540-48910-X_16.pdf)
* [The Paillier Cryptomsysem](https://s68aa858fd10b80a7.jimcontent.com/download/version/0/module/4931760061/name/paillier.pdf)
* [长安链同态加密方案设计文档](https://docs.chainmaker.org.cn/v1.2.4/html/tech/Paillier%E5%8D%8A%E5%90%8C%E6%80%81%E5%8A%A0%E5%AF%86%E7%AE%97%E6%B3%95%E6%96%B9%E6%A1%88%E4%BB%8B%E7%BB%8D.html)
* [https://blog.csdn.net/caorui_nk/article/details/83305709#_18](https://blog.csdn.net/caorui_nk/article/details/83305709#_18)
* [Composite number wiki](https://en.wikipedia.org/wiki/Composite_number)
* [Decisional composite residuosity assumption wiki](https://en.wikipedia.org/wiki/Decisional_composite_residuosity_assumption)
* [group theory](https://chenliang.org/2021/02/26/group-theory/)
* [euler totient caculator](https://www.dcode.fr/euler-totient)
* [Paillier cryptosystem wiki](https://en.wikipedia.org/wiki/Paillier_cryptosystem)
* [二项式定理](https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%A1%B9%E5%BC%8F%E5%AE%9A%E7%90%86)
* [欧拉定理](https://zh.wikipedia.org/zh-hans/%E6%AC%A7%E6%8B%89%E5%AE%9A%E7%90%86_(%E6%95%B0%E8%AE%BA))
* [二项式定理证明Paillier加密](https://cdcq.github.io/2022/04/17/20220417a/)
* [Paillier 的高效实现](https://snowolf0620.xyz/index.php/crypto/459.html)
