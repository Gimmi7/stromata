# 群论

群论是抽象代数的一个分支，主要研究一个被称为【群】的代数结构。

一个群 = 一个集合 + 一个二元运算。集合由一堆元素构成（比如 数字集合， 点集合， 符号集合）， 二元运算结合任意两个元素 a 和 b 形成了一个属于集合的元素。一个群应该满足下面4个属性:

1. closure： 封闭性，二元运算的结果还是属于集合。
2. associativity: 结合律, 举个例子： \\( (a \Box b) \Box c = a \Box (b \Box c) \\)
3. identity element: 单位元，单位元跟二元运算有关，比如加法的单位元为0，乘法的单位元为1，\\( a \Box e = e \Box a= a \\).
4. inverse: 逆元，\\( a \Box a^{-1} = a^{-1} \Box a = e \\)

如果除了上面4个条件之外，群还满足交换律，则群为**交换群**(commutative group)，又叫做**阿贝尔群**(Abelian group) .

举个例子： 椭圆曲线上面的【点集】和 【点的加法】 就构成了一个群。 两个点相加得到的点依然在椭圆曲线上，满足封闭性。\\( (P_1+P_2)+P_3 = P_1 + (P_2+P_3) \\) 满足结合律。 椭圆曲线的单位元是无穷远点，任何点和无穷远点相加，结果等于自身。椭圆曲线的逆元是一个点关于 x 轴对称的点，一个点和该点的逆元相加，结果等于无穷远点。

## 群的阶和集合元素的阶

群的阶就是集合中元素的个数。

集合元素的阶就是由元素反复进行二元运算生成的子集合的阶。如果二元运算是乘法，那么元素 a 的阶就是使得 \\( a^m=e \\) 成立的最小正整数 m 。

## 数学映射的定义

![math_map](../assets/math_map.png)

## 置换

一个有限集合 S 到自身的双射称为 S 的一个置换，集合 \\( S={a_1,a_2,\cdots,a_n} \\)上的置换可以表示为
\\[ f=\begin{pmatrix}
  a_1,a_2,\cdots,a_n \\\\
  a_{p_1},a{p_2},\cdots,a{p_n}
\end{pmatrix}
 \\]
意为将 \\( a_i \\)映射为 \\( a_{p_i} \\), 其中 \\( p_1,p_2,\cdots,p_n \\) 是 \\( 1,2,\cdots,n \\)的一个排列。显然 S 上的所有置换的数量为 n!。

## 对称群 (symmetric group) 和 置换群 (permutation group)

给定一个集合 M, 集合M的所有置换构成集合 N, N 关于置换的乘法(更准确的表述为“映射的合成”)满足封闭性，结合律，有单位元 (恒等置换，即每个元素映射到它自己)，有逆元 (交换置换表示中的上下两行)，因此构成一个群，称为 M 的对称群，记为\\( Sym(M) \\).

\\( Sym(M) \\)的任一子群称为 M 的置换群。

如果 M 是包含 n 个元素的有限集， 称其到自身的可逆映射为 **n阶置换** (permutation)， 其对称群称为 **n阶对称群**(sysmmetric group of degree n).

## References

* [代数结构入门：群、环、域、向量空间](http://sparkandshine.net/algebraic-structure-primer-group-ring-field-vector-space/)
* [wiki: Permutation](https://en.wikipedia.org/wiki/Permutation)
* [wiki: Permutation group](https://en.wikipedia.org/wiki/Permutation_group)
* [wiki: Symmetric group](https://en.wikipedia.org/wiki/Symmetric_group)
* [wiki: Bijection, injection and surjection](https://en.wikipedia.org/wiki/Bijection,_injection_and_surjection)
* [知乎:排列与对称群](https://zhuanlan.zhihu.com/p/402197369)
* [wiki: 对称群](https://zh.wikipedia.org/wiki/%E5%AF%B9%E7%A7%B0%E7%BE%A4_(n%E6%AC%A1%E5%AF%B9%E7%A7%B0%E7%BE%A4))
* [wiki:置换群](https://zh.wikipedia.org/wiki/%E7%BD%AE%E6%8D%A2%E7%BE%A4)
* [oi-wiki: 群论]
