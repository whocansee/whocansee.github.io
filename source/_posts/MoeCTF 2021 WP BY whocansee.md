layout: post

date: 2021-09-26 11:25:19

title: 2021 MoeCTF WP By whocansee

tags: Misc 解题报告 CTF

categories: 技术

aplayer: true

author: whocansee

readmore: true

description: 简单的WP~

----------------------------------------------------------------------------------------------

> 本人其它方向水平实在有限,这次就先写MISC类吧

- find_me

  ​	签到题,把题目给的文件放进010editor里搜一下ctf就可以了

- Macross

  ​	必应搜索题给文件后缀名,发现属于宏脚本文件,下载对应的程序,把文件放进去运行即得flag	

- Homework

  ​	题目给的是word文档,我拿到后打开,发现了歌颂网络安全的一大段文字,尝试打开了隐藏文字

  ​    啥也看不见,咋回事?  后来查资料发现隐藏文字在**白色背景**下显示不出来,所以打开了**护眼背景**

  ​	顺利发现一处异常,试着复制下来粘贴在Notepad上,找到**一截**flag

  [![4clxx0.png](https://z3.ax1x.com/2021/09/26/4clxx0.png)](https://imgtu.com/i/4clxx0)

[![4c1PZF.png](https://z3.ax1x.com/2021/09/26/4c1PZF.png)](https://imgtu.com/i/4c1PZF)

> ​	没错,真的是**<u>一截</u>**

从这里开始就陷入怪圈了,忙活了许久也没发现答案,遂暂时放下   

后来知识(~~套路~~)增进以后想到会不会是文档包含了其它的东西,于是拖进010editor中分析,发现文件头是zip的50 4B 03 04,于是改后缀名为zip解压缩

> 这时我还不会用Kali = =

[![4c1ia4.png](https://z3.ax1x.com/2021/09/26/4c1ia4.png)](https://imgtu.com/i/4c1ia4)

得到这些东西,每个文件夹都看了一遍,一时也没想出下一步咋办

后来偶然看到一篇WP,里面的做法是打开word文件夹内的documents.xml文件,搜索flag,得到了答案

我照做,但并没有直接得到flag

[![4clv2q.png](https://z3.ax1x.com/2021/09/26/4clv2q.png)](https://imgtu.com/i/4clv2q)			根据xml的特点,查找w:t  将符合格式的字符串多次拼接后得到最终flag

> PS:我到最后仍未理解Hint中的字数不够和隐藏文字有啥联系(因为隐藏文字不算word字数)





- flipflipflip

  ​	分析题目后,整了个导图

  ​	![image-20211006163140530](C:\Users\who'can'se'e\AppData\Roaming\Typora\typora-user-images\image-20211006163140530.png)

  ​	等到操作起来,发现真正卡壳的地方完全不在图上.......

  ```python
  import base64
  import sys
  s = open(r"C:\Users\who'can'se'e\Desktop\CTF\TASK\task.txt").read().encode('utf-8')
  m = "moectf"
  while not str(s, encoding='utf-8').startswith(m):
       try:
          s=base64.b64decode(s)
          continue
       except:
          s = s[::-1]
          continue
  
  with open('answer.txt','w', encoding='utf-8') as file:
      file.write(str(s,'utf-8'))
  print("ok!")
  ```

  这是我改进许久后的一段代码,但仍然在输出文本为700多K大小时进行不下去了,以下是报错代码

  ![image-20211006163712648](C:\Users\who'can'se'e\AppData\Roaming\Typora\typora-user-images\image-20211006163712648.png)

  查资料![image-20211006163910694](C:\Users\who'can'se'e\AppData\Roaming\Typora\typora-user-images\image-20211006163910694.png)

  ![image-20211006164207282](C:\Users\who'can'se'e\AppData\Roaming\Typora\typora-user-images\image-20211006164207282.png)

  但我用的就是UTF-8啊,这咋办?

- white album

  > ​	又是白色相簿的季节~

  打开图片,发现是white album galgame的插图,没看出什么玄机,于是拿StegSolve试试,结果左右摁了半天都没发现异样

  看了一些WP后察觉到可能是宽高被修改过的问题,于是拿出010Editor查看,发现宽高果然不一样,修改后得到完整图片

  下面多了一截二维条码,然而当时无知的我还以为是二维码的五个部分,于是臆想五部分＋三个角＋一个地方随便放

  拼接成二维码,歪歪扭扭的裁剪下来后发现了一个严重的问题:拼接顺序,后无法解决,询问Noah学长后得知没有这么复杂

  > ​	错误的灵感来自于某些中间部分拿图标挡住的商业二维码

  卡壳后不死心,拿支付宝扫了下这个码,出乎意料的是竟然能扫描,但呈现出来的页面是"您的彩票失效了",查找关键字发现

  这意味着解码错误,我忽然间想到会不会是这个码非常特殊,支付宝用了解析别的码的方式解析它导致出错,说干就干,我查

  了常见二维条码,功夫不负有心人,最终发现了此类条码的名字,随后花费半小时找到对应的解码工具,拿到Flag~

- Phone Call

  > ​	题目的简介把我逗乐了,笑了好一会儿

  题目的意思还是比较明确的,要求把拨号声转换为真实的号码,我搜索关键字后得到了许多原理剖析文章,但我要的不是这个,

  而是现成能用的工具-----------------------------------

  

  
