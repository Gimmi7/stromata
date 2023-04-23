# 中国剩余定理 (Chinese Remainder Theorem)

中国剩余定理可以用来求解同余方程组的解：
\\[
  \begin{cases}
  x \equiv a_1 \pmod {n_1} \\\\
  x \equiv a_2 \pmod {n_2}  \\\\
  \quad \vdots  \\\\
  x \equiv a_ \pmod {n_k}
  \end{cases}
\\]

其中 \\( n_1,n_2,\cdots,n_k \\) 两两互质。

## 计算过程

* 计算所有模数的乘积 \\( n=n_1 n_2 \cdots n_k \\)
* 对于第 i 个方程：
  * 计算 \\( m_i=\frac{n}{n_i} \\)
  * 计算 \\( m_i \\) 在模 \\( n_i \\) 下的逆元 \\( m_i^{-1} \\),即 \\( m_i m_i^{-1} \equiv 1 \pmod{n_i} \\)
  * 计算 \\( c_i=m_i m_i^{-1} \\)  (**不要对\\(n_i\\)取模**)
* 方程组在模n意义下的唯一解为： \\( x=\sum_{i=1}^k a_i c_i \pmod n \\)

## References

* [oi wiki: crt](https://oi-wiki.org/math/number-theory/crt/)
