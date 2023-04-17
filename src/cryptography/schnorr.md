# Schnorr Signature

## Schnorr Key Generation

* private key: \\(d_A\\)
* public key: \\(Q_a=d_A*G\\)

## Schnorr Sign

* Generate a random secret integer: \\(r\\)
* Calculate: \\(R=r*G\\)
* Calculate: \\(h=hash(R+msg)\\)
* Calculate: \\(s=r-h*d_A\\)
* signature: \\((s,h)\\)

## Schnorr verify signature

* Calculate: \\(R_v=s\*G+h\*Q_a\\)
* Calculate: \\(h_v=hash(R_v+msg)\\)
* Return: \\(h_v==h\\)

## Proof

\\(R_v=s\*G+h\*Q_a\\) \
\\(=(r-h\*d_A)\*G+h\*d_A\*G\\)  \
\\(=r\*G\\)  \
\\(=R\\)

## The importance of random r

If you reuse the random nonce r on two Schnorr signatures of different messages will leak your secret key.

\\(s_1=r_1-h_1\*d_A\\)  \
\\(s_2=r_2-h_2\*d_A\\)  \
\\(s_1-s_2=(r_1-r_2)-d_A*(h_1-h_2)\\) \

If \\(r_1==r_2\\), then \\(d_A\\) is leaked.

## References

* [wiki/Schnorr_signature](https://en.wikipedia.org/wiki/Schnorr_signature)
