# Groth16: zkSNARKs

zero knowledge succinct non-interactive arguments of knowledge.

## bilinear groups

bilinear groups $(p, \mathbb{G_1}, \mathbb{G_2}, \mathbb{G_T}, e,g,h)$ with the folloing properties: \

- $\mathbb{G_1}, \mathbb{G_2}, \mathbb{G_T} $ are groups of prime order p
- The pairing e: $\mathbb{G_1} \times \mathbb{G_2} \rightarrow \mathbb{G_T} $ is a bilinear map
- g is a generator for $\mathbb{G_1}$, h is a generator for $\mathbb{G_2} $, and $e(g,h)$ is a generator for $\mathbb{G_T} $
- There are efficient algorithms for computing group operations, evaluating the bilinear map, deciding memberships of the ghe groups, deciding equality of group elements and sampling generators of the groups. We refer to these as generic group operations.

**linear map**: In the context of groups, a linear map is indeed a homomorphism. After the map funtion, the operations of group preserved.

**bilinear map**: $e: \mathbb{G_1} \times \mathbb{G_2} \rightarrow \mathbb{G_T} $ if a bilinear map, when we hold the first entry of the bilinear map fixed while letting the second entry vary, the result is a linear operator, and similarily for when we hold the second entry fixed.

Groth's constant size NIZK argument is based on constructing a set of polynomial equations and using pairings to efficiently verify these equations.

## bilinear group types

$e: \mathbb{G_1} \times \mathbb{G_2} \rightarrow \mathbb{G_T} $, there are many ways to set up bilinear groups both as symmetric bilinear groups where $\mathbb{G_1} =\mathbb{G_2} $ and asymmetric bilinear groups where $\mathbb{G_1} \not= \mathbb{G_2} $.

- Type 1: $\mathbb{G_1} = \mathbb{G_2} $
- Type 2: thers is an efficiently computable non-trivial homomorphism $\Psi: \mathbb{G_2} \rightarrow \mathbb{G_1} $
- Type 3: no such efficiently computable homomorphism exists in either direction between $\mathbb{G_1} $ and $\mathbb{G_2} $

Asymmetric bilinear groups have higher efficiency than symmetric bilinear groups. \
Type 3 bilinear groups are the most efficient type of bilinear groups and hence most relevant for practical applications.

## pairing product

## field

[BCI+13] propose a  transformation in the symmetric bilinear group setting, where each field element gets compiled into two group elements.

## R1CS

Rank 1 Constraint System, 阶为1的等式。\
任意多项式时间算法均有一组对应的阶为1的等式。


## References

- [Groth16 paper](https://eprint.iacr.org/2016/260.pdf)
- [arkworks: groth16 implementation](https://github.com/arkworks-rs/groth16/tree/master)
- [wiki: linear map](https://en.wikipedia.org/wiki/Linear_map)
- [wiki: binear map](https://en.wikipedia.org/wiki/Bilinear_map)
- [Groth16 学习笔记](https://community.dorahacks.io/t/blockchain-and-cryptography-5-groth16/201)
