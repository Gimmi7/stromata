# Partical Network

## Sign-in & sign-up with Amazon Cognito

[what-is-amazon-cognito](https://docs.aws.amazon.com/cognito/latest/developerguide/what-is-amazon-cognito.html)

## Encrypt with AWS KMS

[API_GenerateDataKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_GenerateDataKey.html)

[API_Decrypt](https://docs.aws.amazon.com/kms/latest/APIReference/API_Decrypt.html#API_Decrypt_RequestParameters)

## Steps for generate share

* Generate ecdsa **share**
* Get **Cognito token**
* Get **aws credential** (which can used to access **aws kms**) by Cognito token
* Access aws kms to generate **data key**, aws kms will response **data key** and **encrypted data key** simultaneously
* Use **data key** to encrypt share (if set **master password**, use master password to encrypt the encrypted share)
* Send **encrypted share** and **encrypted data key** to Particle server

## Steps for load share

* Particle server response the **encrypted share** and **encrypted data key** to client after sign-in
* If set **master password**, use master password to decrypt, then got an encrypted share which was encrypted by aws kms data key
* Get **Cognito token**
* Get **aws credential** (which can used to access **aws kms**) by Cognito token
* Access aws kms to decrypt **encrypted data key**
* Use **data key** to decrypt **encrypted share**
