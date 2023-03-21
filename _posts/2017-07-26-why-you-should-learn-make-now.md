---
layout: post
title: Learn `make`
image: assets/images/logo_make.png
description: 5 ideas why to learn it
date: '2017-07-26 13:26:53 +0200'
categories:
  - DevOps
  - Programming
tags:
  - software
  - automation
  - make
  - DevOps
  - makefiles
  - script
  - scripting
  - software automation
  - tools
---

Maybe you have felt from time to time the speed of the current technology development. Maybe you have taken decisions like "I will choose the latest technology for my new project". And maybe in the middle of the development, you realized your decisions delay you because the new technologies you have chosen are... Well, _new_.

# 1.- Is standard

It conforms to section 6.2 of IEEE Standard 1003.2-1992 (POSIX.2). So the basics are there for you, no matter where you execute your makefiles. Particularly useful is the GNU version of make where some clever features have been added though. It _always_ goes straight to the point.

No surprises.

No random failures.

No dependencies.

No additional requirements.

# 2.- Is compact and clean

Only two types of statements: Variable assignments and rules. Additionally, rules are written as recipes, those you follow at home preparing a nice _risotto_.

```
VARIABLE := value

dish: ingredient1 ingredient2 ingredient3
    action1
    action2
    action3
```

But take a look at the real thing and try to get the pattern. It doesn't look that complex, isn't it?

```
PYTHON_EXEC             := python3
DEVPI_SERVER_ADDRESS    := localhost:3141

python.release: python.check
    $(PYTHON_EXEC) setup.py sdist
    devpi use $(DEVPI_SERVER_ADDRESS)
    devpi login admin --password admin1234
    devpi use root\/dev
    devpi upload dist/$(PROJECT_NAME)-$(PROJECT_VERSION).tar.gz
    devpi logoff
```

# 3.- Is smart

If you write your makefiles properly Make will always perform the minimum amount of operations to achieve any goal. As it checks the timestamps of files you have generated if the files you are generating are older than the _ingredient files_ then Make will not do anything for that file. # 4.- Is insanely fast Parsing all recipes and variables takes no time. It is so fast that in Linux you can use Shell auto-completion instantaneously. And believe me: if you have thousands of files this makes your life much easier.

```
me@mypc:~/test_folder                                       git master
$ cat Makefile
TARGETS:= $(wildcard *.txt)

$(TARGETS):
        echo '$@'
me@mypc:~/test_folder                                       git master
$ make test ..TAB TAB..
test01.txt  test03.txt  test05.txt  test07.txt  test09.txt  test11.txt
test13.txt  test15.txt  test17.txt  test19.txt  test21.txt  test23.txt 
test25.txt  test27.txt  test29.txt  test02.txt  test04.txt  test06.txt 
test08.txt  test10.txt  test12.txt  test14.txt  test16.txt  test18.txt
test20.txt  test22.txt  test24.txt  test26.txt  test28.txt  test30.txt
me@mypc:~/test_folder                                       git master
$ make test
```

# 5.- It will surprise you

Since I started using Make there is no day when I realize cleaver features that were embedded in it that can be used to automate _any_ process. Sometimes when I realize some feature will be very useful I just look into the manual and is already implemented for me to use! No other language I ever used achieved that level of _convenience_ for me before.

--------------------------------------------------------------------------------

In conclusion, Make for me is a really powerful tool that has been a bit undervalued by young developers (I think due to its apparent initial time investment). But when you know it, you'll see that rapidly pays off the investment. Make is a beautiful tool.
