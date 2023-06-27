# Pairing

配对函数又被称为双线性映射函数(bilinear map).在群 $G_1$ 和群 $G_2$分别选取一个点，将这两个点相乘得到目标群 $G_T$ 上的一个点。
$$ e: G_1 \times G_2 \rightarrow G_T $$

椭圆曲线配对函数满足一些特殊的性质：  \
$A,B,C$为群$G_1 或 G_2$上的点，$n$ 为任意整数。
$$
e(A,B+C) = e(A,B)\cdot e(A,C) \\
e(A+B,C) = e(A,C)\cdot e(B,C) \\
e(nA,B)= e(A,nB) = e(A,B)^n
$$

此外，配对函数不可退化(non-degeneracy)
$$e(G,G)\neq 1 $$
"1"代表目标群$G_T$的乘法单位元，不可退化表示只要配对选取的点不是椭圆曲线的单位元(无穷远点)，那么配对后的点也不会是目标群的单位元。

举个例子，实数域的映射函数 $e(x,y)=2^{xy} $ 是双线性映射：  \
$e(3, 4+5)= e(3,9)= 2^{3\times 9}= 2^{27} \\
e(3, 4+5)= e(3,4)\times e(3,5)= 2^{12} \times 2^{15}= 2^{27}
$

## References

- [Vitalik: Exploring Elliptic Curve Pairings](https://medium.com/@VitalikButerin/exploring-elliptic-curve-pairings-c73c1864e627)
- [Joshua: What are zk-SNARKs? Pairings](https://medium.com/coinmonks/what-are-zk-snarks-pairings-part-1-a76b58f1a51b)
- [Joshua: Elliptic Curve Pairings](https://medium.com/statebox/elliptic-curve-pairings-213131769fac)
- [椭圆曲线双线性配对](http://accu.cc/content/cryptography/ecc_pairing/)
- [Craig Costello: Pairings for beginners](https://static1.squarespace.com/static/5fdbb09f31d71c1227082339/t/5ff394720493bd28278889c6/1609798774687/PairingsForBeginners.pdf)
- [Bilinear Pairings in Cryptography](https://www.math.ru.nl/~bosma/Students/MScThesis_DennisMeffert.pdf)
