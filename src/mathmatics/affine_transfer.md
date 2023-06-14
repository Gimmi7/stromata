# Affine transfer

仿射变换又称为仿射映射，是指在几何中，对一个向量空间进行一次线性变换并拼接上一个平移，变换成另一个向量空间。一个对向量 $\vec{x}$平移$\vec{b}$,并且旋转缩放$A$的仿射映射为：
$\vec y =A\vec x + \vec b$

 在齐次坐标下,上式等价为：

 $\begin{bmatrix}
 \vec y \\
  1
 \end{bmatrix}=
 \begin{bmatrix}
 \vec A & \vec b \\
 0,\dots,0 & 1
 \end{bmatrix}
 \begin{bmatrix}
 \vec x \\
 1
 \end{bmatrix}
 $
