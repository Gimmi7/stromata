# 欧几里德算法计算最大公约数 (greatest common divisor)

对于两个非负整数  a,b , 他们的【最大公约数】一般表示为 gcd(a,b), 对应的数学表达式为：
\\[ gcd(a,b)= max \\{ k>0 : (k|a) \ and \ (k|b) \\} \\]
符号 "|" 代表整除，例如 "5 | 10"表示5整除10.

特别地，如果两个数中一个数为0，另一个数不为0，那么两个数的最大公约数为非零的那个数。如果两个数都为0，则认为它们的最大公约数不存在。

## 欧几里德算法

欧几里德的算法思想如下，假设 a>b, 如果 d 同时整除 a 和 b，那么 d 也整除 (a-b), 也就是 (a,b)和(a,a-b)的最大公约数等价，使用同样的方法，可以使用大数减去小数得到【差】， 则 (a,b)的最大公约数等价于 (小数，差) 的最大公约数， 可以不断重复这个步骤，直到其中一个数为0，另外一个数就是最大公约数。

a-b的过程中，a一直都比b大，除非做了 \\( \lfloor\frac{a}{b}\rfloor \\) 次减法，所以为了加速做减法的过程， a-b 被替换为
\\( a-\lfloor\frac{a}{b}\rfloor b = a \bmod b   \\), 算法公式为：

\\[
  gcd(a,b)=
  \begin{cases}
  a, & if \ b=0   \\\\
  gcd(b, a \bmod b), &  otherwise
  \end{cases}
\\]

## 算法实现

```rust,editable
fn main() {
    println!("{}", euclidean_gcd(8, 4));
}

fn euclidean_gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        return a;
    }
    euclid_gcd(b, a % b)
}
```

## References

* [Competive-Programing: euclid-algorithm](https://cp-algorithms.com/algebra/euclid-algorithm.html)
