---
layout: post
title: Integrating `jsonlint` in your CI
date: '2017-05-02 15:12:26 +0200'
categories:
  - DevOps
tags:
  - automation
  - test
  - make
  - DevOps
  - continous integration
  - json
  - lint
  - CI
  - Jenkins
---

Today I received a pull request on a JSON file and it was wrong. We decided to look for a linting solution to run on our CI with some requirements:

- It should **validate** and point out broken JSON.
- It should **fix the indentation**.
- It should **not sort** JSON objects.

After some research, we found different options with different levels of **quality** and **liveliness**. Actually, the most difficult part of looking for solutions sometimes is strongly influenced by those 2 factors. But I wouldn't compare them today, so we finally decided to go for [npm jsonlint](https://www.npmjs.com/package/jsonlint).

Is easy to install:

```
npm install -g jsonlint
```

And easy to use:

Usage: jsonlint [file] [options]

```
file     file to parse; otherwise uses stdin

Options:
  -v, --version            print version and exit
  -s, --sort-keys          sort object keys
  -i, --in-place           overwrite the file
  -t CHAR, --indent CHAR   character(s) to use for indentation  [  ]
  -c, --compact            compact error display
  -V, --validate           a JSON schema to use for validation
  -e, --environment        which specification of JSON Schema the validation file uses  [json-schema-draft-03]
  -q, --quiet              do not print the parsed json to STDOUT  [false]
  -p, --pretty-print       force pretty printing even if invalid
```

# Test integration

In our case we basically deploy a set of _Makefiles_ with every project where we define some standard targets like _release_, _test,_ or _fix_ so basically I decided to add another linting check to the **test** target like so:

```
test: json.validate
json.validate:
    @for f in $(find . -type f -name "*.json"); do \
      jsonlint $f -p | sed -e '$a\' | diff $f -; \
      if [ $? -ne 0 ]; then \
        echo "Error validating $f." ; \
        exit 1 ; \
      fi \
    done
```

The _for_ loop iterates through all the _JSON_ files found doing a diff using jsonlint with the pretty-print flag.

```
jsonlint $f -p | sed -e '$a\' | diff $f -;
```

Note the use of _sed_ to append a _new line_ to the stream so that diff does not throw an error "No newline at end of file". After the target is set in the _Makefile_ everything is done as in our _Jenkinsfile_ we have something like this already:

```
stage("Test") {
  steps {
    sh 'make test'
  }
}
```

# Fix integration

As done for the testing the _fixed_ target does exactly the same operation but applies the changes to the files directly. This target is going to be executed by developers before creating a _Pull request_ as a cleanup step so is not critical to be fast so some more checks are executed to make it clean.

```
fix: json.fix
json.fix:
    @for f in $(find . -type f -name "_.json"); do \ jsonlint $f -q && jsonlint $f -qpi && sed -i -e '$a\' $f ; \ echo "Formatted $f" ; \ if [ $? -ne 0 ]; then \ echo "Error validating $f" ; \ exit 1 ; \ fi \ done_
```

_The fixing process **first validates** the JSON in order to avoid errors and also minimize the output on the CI. If_ jsonlint _fails validation with the_ pretty-print _option this will output all the files to stdout. That is why you see_ jsonlint* called twice.

```
jsonlint $f -q && jsonlint $f -qpi && sed -i -e '$a\' $f
```

Note the '-i' flag to edit the file _in place_. Also, note the usage of _sed_ to append the _new line_ to the file so that after this automatic fix the file is guaranteed to pass the validation step.
