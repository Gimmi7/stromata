# Partial Discrete Logarithm

The partial discrete logarithm problem is a variant of the discrete problem, which a fundamental cryptographic problem. In the discrete logarithm problem, given a base **g**, a prime modulus **p**, and an element $h \in Z_p^* $, the goal is to find an integer **x** such that $g^x \equiv h \pmod{p} $.

The partial discrete logarithm problem introduces a slight modification to this problem. Instead of finding the full value of x, the objective is to find only a partial value of x, denoted as **x'** such that $x =x'+k\cdot r $, where r is a known fixed integer, and k is an unknown integer.

PDL offers a way to compute partial logarithms, which can be utilized to establish shared secrets or perform other cryptographic operations.

The PDL problem is considered computationally hard, meaning that there are no known efficient algorithms to solve it for large valus of p and g. The security of cryptographic schemas relying on the partial discrete logrithm problem is based on the assumption that no efficient algorithm exists to solve it.
