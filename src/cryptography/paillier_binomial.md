# 通过二项式证明 Paillier 同态加密

一般地，对于一个定理，通常的学习方法是先知道了结论，然后通过某些数学公式推导出结论，这里把这种方法称为逆向学习法。本文试图通过二项式定理从正向的思考方式证明 Paillier 同态加密。

## 二项式定理

两个数的整数次之幂诸如 \\((x+y)^n\\) 可以展开为多个形如 \\(ax^by^c\\) 的项的和，其中 b,c 均为非负整数，且\\(b+c=n\\), a 为二项式的系数。高中数学里面的 **平方和公式** 就是二项式定理的一个特例，\\((a+b)^2=a^2+b^2+2ab\\)

### 定理的陈述

\\( (x+y)^n= \binom{n}{0}x^ny^0 + \binom{n}{1}x^{n-1}y^1 + \binom{n}{2}x^{n-2}y^2 +\cdots+ \binom{n}{n-1}x^1y^{n-1} + \binom{n}{n}x^0y^n \\)

其中 \\( \binom{n}{k} \\) 被称为二项式系数，其等于 \\( \frac{n!}{k!(n-k)!} \\)

二项式定理的一个变形是将 y=1 代入公式，这样二项式公式中就只涉及一个变量 x :

\\( (1+x)^n=\binom{n}{0}x^0 + \binom{n}{1}x^1 + \binom{n}{2}x^2 +\cdots+ \binom{n}{n-1}x^{n-1} + \binom{n}{n}x^n \\)

### 定理的证明

二项式系数  \\( \binom{n}{k}=\frac{n!}{k!(n-k)!} \\) 就是高中数学的【排列与组合】章节中的组合数公式。

\\( (x+y)^n= (x+y)(x+y)(x+y) \cdots (x+y) \\) , 每一个\\( (x+y) \\) 称为乘法因子

二项式的每一个项为 \\( ax^ky^{n-k} \\)，我们如果在n个乘法因子中选择了 k 个 x ，再从剩下的 (n-k) 个乘法因子选择 (n-b)个 y ,便能得到一组 \\( x^ky^{n-k} \\), 而这样的选法总共有 \\( \binom{n}{k} \\) 种。

## 对数和离散对数

### 对数

如果\\( b^x=y \\)，那么 x 叫做以 b 为底 y 的对数， 记做 \\( x=\log_b y \\)

### 离散对数

如果 \\( b^x  \equiv y \pmod n \\), 离散对数问题就是在已知 b,y的情况下求 x 的过程。
离散对数问题一般被认为很难求解，特别是当 'n' 是一个很大的质数或者当 b 是整数模n群的生成元。

## 二项式可以很容易地求解求解某些离散对数

根据二项式定理，我们有：

\\[ (1+n)^x= \sum_{k=0}^x \binom{x}{k}n^k \\]

将其转化成模\\( n^2 \\)的表达式：

\\( (1+n)^x \equiv \binom{x}{0}n^0 + \binom{x}{1}n + \binom{x}{2}n^2 + \cdots + \binom{x}{x}n^x \equiv 1+nx \pmod {n^2} \\)

两边变形可得：

\\( x \equiv \frac{(1+n)^x-1}{n} \pmod {n^2} \\)

这意味着在已知形如\\( (1+kn)^x \\)的数的情况下，我们可以轻松地计算在模 \\(n^2\\)意义下关于\\( (1+kn)\\) 的对数, 计算方法就是通过函数：

\\( L=\frac{x-1}{n} \\) , 这里的 x 是\\( (1+kn)^x \\)的整体替换

## 整数模n乘法群

在同余理论中，模n的互质同余类构成一个乘法群，称为 **整数模n乘法群**。 这个群是数论的基石，在密码学、整数分解和素性测试中均有运用。

整数模n乘法群用符号表示为 \\(Z_n^*\\), 一般地， \\(Z_n\\) 表示整数模n加法群。

## 欧拉函数和卡迈克函数

欧拉函数表示为 \\( \phi(n) \\) 或者 \\( \varphi(n) \\), 欧拉函数计算小于n且和n互质的正整数的个数，其实也就是计算整数模n乘法群的阶。（群的阶order,指的是群中元素的个数）。

卡迈克函数表示为 \\( \lambda(n) \\), 卡迈克函数计算使得**所有**和n互质的所有正整数 a （需要满足所有的a）, 满足 \\( a^m \equiv 1 \pmod n \\) 的最小的正整数 m。Carmichael funtion有一个准确描述的名字叫【最小通用指数函数】(least-universal-exponent-funtion);
在代数术语中，\\( \lambda(n) \\)是整数模n乘法群的指数。

## 同态加密/解密

**初始设置：**

* 选择两个大质数 p,q
* 计算合数 n=pq
* 计算最小通用指数 \\( \lambda(n)=lcm(p-1, q-1) \\)

**加密:**

加密的过程就是就是生成乘法子群的过程 \\( Z_n \times Z_n^\* \rightarrow Z_{n^2}^\*  \\)
\\[ (m,r) \rightarrow g^m \cdot r^n \pmod{n^2} = c \\]
m: plaintext message \
r: random number for \\( Z_n^\* \\) \
c: ciphertext

**解密:**

\\[ m=\frac{L(c^{\lambda} \bmod{n^2})}{L(g^{\lambda} \bmod{n^2})} \bmod{n} \\]
\\[ L(x)=\frac{x-1}{n} \\]

**证明:**

\\( c^{\lambda} \bmod{n^2}= (g^m r^n)^{\lambda} \bmod{n^2}= g^{m\lambda}r^{n\lambda} \bmod{n^2} \\) \
\\( \because r^{n\lambda} \equiv 1 \pmod{n^2}  \\)  \
\\( \therefore c^{\lambda}=g^{m\lambda} \bmod{n^2} \\)
\\( \because g^{\lambda} \equiv 1 \pmod{n} \quad \therefore g^{\lambda}=1+kn \\)   \
\\( \therefore c^{\lambda}=g^{m\lambda} \bmod{n^2}= (1+kn)^m \bmod{n^2}=1+knm \bmod{n^2} \\)  \
\\( Dec=\frac{knm}{kn} \bmod{n}= m \bmod{n}=m \\)

## 证明加密函数双射

映射函数 $\varepsilon_g: Z_n \times Z_n^*\mapsto Z_{n^2}^*, \varepsilon_g(x,y)= g^x \times y^n \pmod{n^2} $

引理：若 g 的阶 $ord_{n^2}(g) $ 是n的非零整数倍，则加密函数 $\varepsilon_g $ 是双射。

证明： 由于 $Z_n \times Z_n^*$ 的元素个数和 $Z_{n^2}^* $ 一样， 只需要证明单射。  \
假设有 $c_1 = g^{m_1} r_1^n \pmod{n^2}, c_2=g^{m_2} r_2^n \pmod{n^2} $    \
如果 $c_1 = c_2$, 两式相除有 \
$g^{m_1-m_2} \cdot (r_1 r_2^{-1})^n \equiv 1 \pmod{n^2} $ ,两边同求取幂有 \
$g^{\lambda(m_1-m_2)} \cdot (r_1 r_2^{-1})^{\lambda n} \equiv g^{\lambda(m_1-m_2)} \equiv 1 \pmod{n^2} $  \
从而有 $ord_{n^2}(g) | \lambda(m_1-m_2) $ \
又 $n|ord_{n^2}(g) \Rightarrow n|\lambda(m_1-m_2) $ \
又因为 $gcd(\lambda, n)=1 $, 所以 $n | (m_1-m_2) $  \
因此在 $m_1,m_2 \in Z_n $的 意义下， $m_1=m_2$ \
得证

## References

* [The Paillier Cryptomsysem](https://s68aa858fd10b80a7.jimcontent.com/download/version/0/module/4931760061/name/paillier.pdf)
* [wiki:二项式定理](https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E9%A1%B9%E5%BC%8F%E5%AE%9A%E7%90%86)
* [cdcq: 二项式证明Paillier](https://cdcq.github.io/2022/04/17/20220417a/)
* [陈：整数模n乘法群](https://chenliang.org/2021/03/04/multiplicative-group-of-integers-modulo-n/)
* [李杰：双射证明同态](https://zhuanlan.zhihu.com/p/514305058)
* [孙晓军：同态原理，实现，应用](https://blog.csdn.net/gameboxer/article/details/126948240)
* [wiki: Carmichael_funciton](https://en.wikipedia.org/wiki/Carmichael_function)
* [OI wiki:中国剩余定理CRT](https://oi-wiki.org/math/number-theory/crt/)
* [wiki: 算术基本定理(质数分解定理)](https://en.wikipedia.org/wiki/Fundamental_theorem_of_arithmetic)
* [使用质数分解定理求解大数的约数个数](https://www.cnblogs.com/wkfvawl/p/9911083.html)
* [中文通过双射证明Paillier](https://www.cnblogs.com/coming1890/p/14561487.html)
