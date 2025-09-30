# Montgomery

## 加速做除法

>以 $101 \div{7}$ 为例

### 人类使用竖式计算除法的过程

$$
\begin{array}{r}
1~4 \phantom{)} \\
7 \overline{\smash{\big)}~1~0~1 \phantom{)}} \\
\underline{-~~~7\phantom{)))}} \\
3~1 \phantom{)} \\
\underline{-~~2~8\phantom{)}} \\
3 \phantom{)} \\
\end{array}
$$

### 计算机使用二进制来计算除法，过程和人类的竖式很接近

从高位开始（从左到右）用被除数减去除数，整个过程相当于把被除数从左到右按位归0，直到余数小于除数。可以总结为**从高到低用减法归0**。

整个过程可以用等式表示为 $D-q*d=r$, 其中D:被除数，d:除数，q:商，r:余数。计算机怎么知道一个位置该商0还是商1呢，计算机的做法叫【商数位估算和校正】，先商1，如果余数为负，再回退改成商0。

$$
\begin{array}{r}
\xrightarrow{\hspace{2cm}}\\
1~1~1~0 \phantom{)} \\
1~1~1 \overline{\smash{\big)}~1~1~0~0~1~0~1 \phantom{)}} \\
\underline{-~1~1~1  \phantom{~0~0~0)}} \\
1~0~1~1 \phantom{~0~0)} \\
\underline{-~1~1~1 \phantom{~0~0)}} \\
1~0~0~0 \phantom{~0)} \\
\underline{-~1~1~1 \phantom{~0)}} \\
1~1 \phantom{)} \\
\end{array}
$$

### 从低到高用加法归0

换一个思路来做除法，与上面的做法相反，尝试一下从低到高（从右到左）用加法进行归0操作。

整个过程可以用等式表示为 $\frac{D+q*d}{R}=r$, 其中 $R=2^{bitlen}$, bitlen指被归0的位数。做加法的过程就不需要进行商数位估算和校正，如果处理的位数为1就商1，为0就商0。

$$
\begin{array}{r}
\xleftarrow{\hspace{2cm}}\\
1~1~0~1 \phantom{)} \\
1~1~1 \overline{\smash{\big)}~1~1~0~0~1~0~1 \phantom{)}} \\
\underline{+\phantom{~0~0~0~0~} 1~1~1  \phantom{)}} \\
1~1~0~1~1~0~0 \phantom{)} \\
\underline{+\phantom{~0~0~} 1~1~1 \phantom{~0~0)}} \\
1~0~0~0~1~0~0~0 \phantom{)} \\
\underline{+\phantom{~0~} 1~1~1 \phantom{0~~0~0)}} \\
1~1~0~0~0~0~0~0 \phantom{)} \\
\end{array}
$$

## References

* [加密算法基础- Montgomery(蒙哥马利)乘法介绍](https://blog.csdn.net/BjarneCpp/article/details/77644958)
* [Long Division Calculator](https://www.calculatorsoup.com/calculators/math/longdivision.php)
* [binary-division-calculator-with-steps](https://madformath.com/calculators/digital-systems/binary-arithmetic/binary-division-calculator-with-steps/binary-division-calculator-with-steps)
* [How to write long division in latex?](https://learnsharewithdp.wordpress.com/2020/05/19/how-to-write-long-division-in-latex/)
* [wiki: Montgomery_modular_multiplication](https://en.wikipedia.org/wiki/Montgomery_modular_multiplication)