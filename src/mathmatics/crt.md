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

## 证明

我们需要证明上面的算法计算所得的 x 满足一元线性同余方程组中任意一个方程，即对于任意的 \\( i=1,2,\cdots,k \\) 满足 \\( x \equiv a_i \pmod{n_i} \\)。

当 \\( i \not= j \\) 时: \
\\( m_j \equiv 0 \pmod{n_i} \\)   \
又因为 \\( c_j= m_j m_j^{-1} \\)  \
所以 \\( c_j \equiv 0 \pmod{n_i} \\)  \
与此同时 \\( c_i \equiv m_i (m_i^{-1} \bmod{n_i}) \equiv 1 \pmod{n_i} \\) \
所以我们有：

\\[
  \begin{align}
  x & \equiv \sum_{j=1}^{k} a_j c_j  & \pmod{n_i} \\\\
    & \equiv a_i c_i    & \pmod{n_i}  \\\\
    & \equiv a_i m_i (m_i^{-1} \bmod{n_i})  & \pmod{n_i}   \\\\
    & \equiv a_i   & \pmod{n_i}
  \end{align}
\\]

即对于任意 \\( i=1,2,\cdots,k \\),上面算法得到的 x 总是满足 \\( x \equiv a_i \pmod{n_i} \\),即证明了求解同余方程组的算法的正确性。

因为我们没有对输入的 \\( a_i \\) 作特殊限制，所以任何一组输入 \\( {a_i} \\) 都对应一个解 x 。

## References

* [oi wiki: crt](https://oi-wiki.org/math/number-theory/crt/)
