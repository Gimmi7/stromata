# 群论

群论是抽象代数的一个分支，主要研究一个被称为【群】的代数结构。

一个群 = 一个集合 + 一个二元运算。集合由一堆元素构成（比如 数字集合， 点集合， 符号集合）， 二元运算结合任意两个元素 a 和 b 形成了一个属于集合的元素。一个群应该满足下面4个属性:

1. closure： 封闭性，二元运算的结果还是属于集合。
2. associativity: 结合律, 举个例子： \\( (a \* b) \* c = a \* (b \* c) \\)
3. identity element: 单位元，单位元跟二元运算有关，比如加法的单位元为0，乘法的单位元为1，\\( a \* e = e \* a= a \\).
4. inverse: 逆元，\\( a \* a^{-1} = a^{-1} \* a = e \\)

如果除了上面4个条件之外，群还满足交换律，则群为**交换群**(commutative group)，又叫做**阿贝尔群**(Abelian group) .

举个例子： 椭圆曲线上面的【点集】和 【点的加法】 就构成了一个群。 两个点相加得到的点依然在椭圆曲线上，满足封闭性。\\( (P_1+P_2)+P_3 = P_1 + (P_2+P_3) \\) 满足结合律。 椭圆曲线的单位元是无穷远点，任何点和无穷远点相加，结果等于自身。椭圆曲线的逆元是一个点关于 x 轴对称的点，一个点和该点的逆元相加，结果等于无穷远点。

## 群的阶和集合元素的阶

群的阶就是集合中元素的个数。

集合元素的阶就是由元素反复进行二元运算生成的子集合的阶。如果二元运算是乘法，那么元素 a 的阶就是使得 \\( a^m=e \\) 成立的最小正整数 m 。

## 群的性质

* (消去律) \\(a \* b= a \* c \Rightarrow b=c \\)
* 方程 \\( a \* x =b  \\) 有唯一解， \\( x \in G \\)
* \\( (a \* b)^{-1}= b^{-1} \* a^{-1} \\)
* \\( (a^{-1})^{-1} = a \\)

## 判断子群

定理：H是G的非空子集，对于任意 \\( a,b \in H \\), 都有 \\( a\* b^{-1} \in H \\), 则 H 是 G 的子群。

**Proof:**

* 先证单位元: 当 a=b 时，有 \\( a \* a^{-1} = e \in H \\), 并且 \\( a\*e=e\*a=a \\),所以G的单元e属于集合H,并且e同时也是H的单位元。
* 再证逆元，我们需要证明任意一个\\( a \in H \\),它的逆元 \\( a^{-1} \in H \\), 这里使用\\( e\*a^{-1}=a^{-1} \in H \\).故而 \\( a^{-1} \\) 不仅是a在G中的逆元，同时也是a在H中的逆元。
* 证明封闭性，封闭性需要证明\\( a\*b \in H \\), 因为\\( b^{-1} \in H \\), 有 \\( a\*b=a\*(b^{-1})^{-1} \in H \\)
* 结合律：因为G是个群，它的子集的元素也必然满足结合律。

定理2: H是群G的非空子集，如果H是有限集，而且G的运算\\( \* \\)在H上满足封闭性，则H是G的子群。

## 陪集(coset)

子群H是群G都子群，H可以用来把G分解成多个元素个数相等且互不相交的子集，这些子集被称为陪集。   \
若 \\( a \in G \\), 则
\\[ aH :=\\{a\*h | h\in H\\} \\]
称为 H 关于 a 在 G 中的左陪集 (left cosets),同理，\
\\[ Ha :=\\{ h\*a | h\in H \\} \\]
称为 H 关于 a 在 G 中的右陪集(right cosets).

陪集的生成过程就是在群G中任意选一个元素a,将a与子群H的元素分别进行二元运算，得到的集合就是H关于a在G中的陪集。其中 a 叫做代表元(representative). 陪集的符号一般表示为 \\([a]_H\\).

**陪集的性质：**

* \\(a \in [a]_H\\), 代表元一定是陪集的元素，因为子集一定包含单位元，\\(e\*a=a\*e=a\\)
* \\( [e]_H=H \\), 代表元为单位元时，陪集和子集相等。
* \\( a\in H \Longleftrightarrow [a]_H=H \\), 代表元是子集的元素时，生成的陪集和子集相等。\
  证明： \\(a \in H \\),  a 和 H 的元素进行二元运算时，由于H具有封闭性，二元运算的结果一定含于H,即 \\( [a]_H \subseteq H \\); \
  另一方面：\\( \forall b \in H , a\in H \\)  \
  \\( a^{-1}\* b \in H \\), 将\\( a^{-1}\*b \\)看做一个整体，与 a 进行二元运算  \
  \\( a\*(a^{-1}\*b) \in [a]_H \Rightarrow b\in [a]_H \Rightarrow H \subseteq [a]_H  \Rightarrow [a]_H=H \\)
* \\( [a]_H =[b]_H \Leftrightarrow a^{-1}\*b \in H (或 b^{-1}\*a \in H ) \\)    \
  证明： \\( H=\\{ e, \cdots, h, \cdots \\} \\) \
    \\( [a]_H=\\{ a,\cdots,a\*h,\cdots \\} \\)  \
    \\( [b]_H=\\{b,\cdots,b\*h,\cdots\\} \\)  \
    因为H关于a的陪集等于H关于b的陪集，所以 b 必定等于 a 与 H 中某个元素进行二元运算，即 \
    \\( b=a\*h \Rightarrow a^{-1}\*b=h \\)  \
    又因为 h 是 H 中的元素 \
    所以 \\( a^{-1}\*b \in H \\)

## 拉格朗日定理(Lagrange's theorem)

定理： G 是**有限群**， H是G的任意子群，则
\\[ ord(H) | ord(G) \\]

证明：因为H的所有陪集\\( [a_1]_H,[a_2]_H,\cdots,[a_n]_H \\)其实是对G的划分，且每个陪集的元素个数相等,所以\\( |G|=k|H| \\), 其中k表示通过H生成的陪集的个数。

举个例子： 群 \\( Z_6= \\{0,1,2,3,4,5\\} \\)  \
子群 \\( 3Z_6=3\times \\{0,1,2,3,4,5\\}=\\{0,3\\} \\) \
陪集: \
$ [0]_{3Z_6}=[3]_{3Z_6}=\{0,3\} $ \
$ [1]_{3Z_6}=[4]_{3Z_6}=\{1,4\} $ \
$ [2]_{3Z_6}=[5]_{3Z_6}=\{2,5\} $

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

所以置换的本质就是一个双射函数。

## 对称群 (symmetric group) 和 置换群 (permutation group)

给定一个集合 M, 集合M的所有**可逆置换**构成集合 N, N 关于可逆置换的复合（函数的复合也可以看作是两个函数间的二元运算）满足封闭性，结合律，有单位元 (恒等置换，即每个元素映射到它自己)，有逆元 (交换置换表示中的上下两行)，因此构成一个群，称为 M 的对称群，记为\\( Sym(M) \\).

\\( Sym(M) \\)的任一子群称为 M 的置换群。

如果 M 是包含 n 个元素的有限集， 称其到自身的可逆映射为 **n阶置换** (permutation)， 其对称群称为 **n阶对称群**(sysmmetric group of degree n).

举个例子： 假设我们有集合 M={1,2,3}, 所有的置换就是对集合M做全排列，结果如下： \
\\(
  \begin{pmatrix}
    1,2,3 \\\\
    1,2,3
  \end{pmatrix}
  \begin{pmatrix}
    1,2,3 \\\\
    2,1,3
  \end{pmatrix}
  \begin{pmatrix}
    1,2,3 \\\\
    3,1,2
  \end{pmatrix}
  \begin{pmatrix}
    1,2,3 \\\\
    1,3,2
  \end{pmatrix}
  \begin{pmatrix}
    1,2,3 \\\\
    2,3,1
  \end{pmatrix}
  \begin{pmatrix}
    1,2,3 \\\\
    3,2,1
  \end{pmatrix}
\\)

以上这六个置换就是就是对称群的元素集合，集合的运算就是对映射函数进行复合操作，单位元就是第一个元素（恒等置换），逆元就是把每一个置换表达中的上下两行交换得到的新的映射函数，而且每次进行复合操作得到的映射函数都是上面的置换之一，且复合函数满足结合律。

## References

* [代数结构入门：群、环、域、向量空间](http://sparkandshine.net/algebraic-structure-primer-group-ring-field-vector-space/)
* [wiki: Permutation](https://en.wikipedia.org/wiki/Permutation)
* [wiki: Permutation group](https://en.wikipedia.org/wiki/Permutation_group)
* [wiki: Symmetric group](https://en.wikipedia.org/wiki/Symmetric_group)
* [wiki: Bijection, injection and surjection](https://en.wikipedia.org/wiki/Bijection,_injection_and_surjection)
* [知乎:排列与对称群](https://zhuanlan.zhihu.com/p/402197369)
* [wiki: 对称群](https://zh.wikipedia.org/wiki/%E5%AF%B9%E7%A7%B0%E7%BE%A4_(n%E6%AC%A1%E5%AF%B9%E7%A7%B0%E7%BE%A4))
* [wiki:置换群](https://zh.wikipedia.org/wiki/%E7%BD%AE%E6%8D%A2%E7%BE%A4)
* [oi-wiki: 群论](https://oi-wiki.org/math/group-theory/)
* [fandom-wiki: 对称群](https://math.fandom.com/zh/wiki/%E5%B0%8D%E7%A8%B1%E7%BE%A4?variant=zh-sg)
* [bilibili: 复合函数结合律的证明](https://www.bilibili.com/video/BV1zZ4y1p793/)
* [permutation-generator](https://www.dcode.fr/permutations-generator)
* [bilibili: Alice-Bob 群论](https://www.bilibili.com/video/BV1qs4y1s7kv/?p=2&spm_id_from=pageDriver&vd_source=950e7977d383cac0e43e8756252ddf3f)
