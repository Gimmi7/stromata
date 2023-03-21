# Cryptography

## Trap door Functions

A trapdoor function is a function that is easy to compute in one direction, yet difficult to compute in the opposite direction (finding its inverse) without special information.

## Why modulo

make the compute irreversible. \
for example: \
\\( 5\times x=500 \hspace{1cm} \rightarrow \hspace{1cm} x=500 \div 5=100 \\) \
\\( 5 \times x \pmod{7}=3 \\), x may equal 2, may equal 16，may equal 100 ...

## identity element of operation

In mathematics, an identity element(恒等元), aka a neutral element,is an element that when combined with another element using a particular operation, leaves the second element unchanged.

For example, in addition, the identity element is zero.In multiplication, the identity element is one.

## Inverse

In mathematics, the term "inverse" refers to an element that,when combined with another element with a particular operation, yields the identity element for that operation.

For example, the inverse of the number 2 with respect to addition is -2, because \\( 2+(-2)=0 \\),the inverse of the number 2 with respect to multiplication is \\( \frac{1}{2} \\), because \\( 2\times \frac{1}{2}=1 \\).In modular arithemetic, the inverse of an element **a** about modulus **m** is **b**, when \\( a\times b \equiv 1 \pmod{m} \\), eg: \\( 2 \times 4 \equiv 1 \pmod{7} \\), so the inverse of 2 abount modulus 7 is 4.

## bijective

In mathematics,a function is said to be bijective if it is both injective and surjective.An injective funtion maps each elemtnt of the domain to a unique element of the range,meaning no two distinct elements in the domain are mapped to the element in the range. A sruijective funtion, on the other hand,maps each element of the range to at least one element in the domain, meaning every element in the range is mapped to by at least one element in the domain.

A bijective function satisfies both of these properties.Bejective functions are sometimes refered to as one-to-one corresondences,as they establish a unique pairing between the elements of the domain and the range.

## References

* [A relative easy way to understand RSA & ECC](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/)
