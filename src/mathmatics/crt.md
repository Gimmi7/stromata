# 中国剩余定理 (Chinese Remainder Theorem)

中国剩余定理可以用来求解同余方程组的解：
$$
  \begin{cases}
  x_1 \equiv r \pmod {m_1} \\
  x_2 \equiv r \pmod {m_2}  \\
  \quad \vdots  \\
  x_k \equiv r \pmod {m_k}
  \end{cases}
$$

其中 \\( m_1,m_2,\cdots,m_k \\) 两两互质。

## 计算过程

* 计算所有模数的乘积 $ m =m_1 m_2 \cdots m_k $
* 对于第 i 个方程：
  * 计算 $ m_{\cancel{i}}=\frac{m}{m_i} $
  * 计算 $ m_{\cancel{i}} $ 在模 $ m_i $ 下的逆元 $ m_{\cancel i}^{-1} $,即 $ m_{\cancel i} m_{\cancel i}^{-1} \equiv 1 \pmod{m_i} $
  * 计算 $ c_i=m_{\cancel i} m_{\cancel i}^{-1} $  (**不要对$m_i$取模**)
* 方程组在模 $m$ 意义下的唯一解为： $ r=\sum_{i=1}^k x_i c_i \pmod{m} $

## 证明

我们需要证明上面的算法计算所得的 r 满足一元线性同余方程组中任意一个方程，即对于任意的 $ i=1,2,\cdots,k $ 满足 $ r \equiv x_i \pmod{m_i} $。

当 $ i \not= j $ 时: \
$ m_{\cancel j} \equiv \frac{m}{m_j} \equiv 0 \pmod{m_i} $   \
又因为 $ c_j= m_{\cancel j} m_{\cancel j}^{-1} $  \
所以 $ c_j \equiv 0 \pmod{m_i} $  \
与此同时 $ c_i = m_{\cancel i} (m_{\cancel i}^{-1} \bmod{m_i})$ ,所以 $ c_i \equiv 1 \pmod{m_i} $ \
所以我们有：

$$
  \begin{align}
  r & \equiv \sum_{j=1}^{k} x_j c_j  & \pmod{m_i} \\
    & \equiv x_i c_i    & \pmod{m_i}  \\
    & \equiv x_i m_{\cancel i} (m_{\cancel i}^{-1} \bmod{m_i})  & \pmod{m_i}   \\
    & \equiv x_i   & \pmod{m_i}
  \end{align}
$$

即对于任意 \\( i=1,2,\cdots,k \\),上面算法得到的 r 总是满足 \\( r \equiv x_i \pmod{m_i} \\),即证明了求解同余方程组的算法的正确性。

因为我们没有对输入的 \\( x_i \\) 作特殊限制，所以任何一组输入 \\( {x_i} \\) 都对应一个解 r。

## 利用CRT来加速大数的模幂运算（用于加速解密RSA和paillier）

直接举个例子： 假设 p=13, q=17, 则 $n=p\times q=221 $ \
接下来利用crt计算 $ 7^{199} \equiv r \pmod{221} $  \
**decompose:**
$$
\begin{cases}
x_1 = 7^{199} \pmod{13}  = 7^{199 \bmod{\phi(13)}} \pmod{13} = 7^7 \pmod{13} =6 \\
x_2 = 7^{199}  \pmod{17} = 7^{199 \bmod{\phi(17)}}  \pmod{17} = 7^7 \pmod{17} =12
\end{cases}
$$
于是乎有下面的同余方程组：
$$
\begin{cases}
6 \equiv r \pmod{13}  \\
12 \equiv r \pmod{17}
\end{cases}
$$

**compose:**
$$
m_{\cancel 1}=\frac{221}{13}=17, m_{\cancel 2}=\frac{221}{17}=13  \\
m_{\cancel 1}^{-1} \bmod 13=10, m_{\cancel 2}^{-1} \bmod 17=4  \\
c_1= 17\times 10=170, c_2= 13 \times 4=52 \\
r= x_1 c_1 + x_2 c_2 \pmod{m}= 6\times 170 + 12\times 52 \pmod{221}=1644 \pmod{221} = 97

$$

## References

* [oi wiki: crt](https://oi-wiki.org/math/number-theory/crt/)
* [RSA-CRT 使用中国剩余定理CRT对RSA算法进行解密](https://blog.csdn.net/qq_43589852/article/details/127691919)
