# Pharo-dev-Extensions
Extensions to Pharo and some of its frameworks that I find handy to use during development

There's a barebones way to load this package in. It might be deprecated by the time you're trying it. Feel free to rummage around the Iceberg code in Pharo ;-)

Anyway, here is what I do in a playground:

```smalltalk
c := IceRepositoryCreator new url: 'git@github.com:melvinroest/Pharo-dev-Extensions.git'.
(c location: c defaultLocation) location exists ifTrue: [ c url: nil ].
c createRepository register.
c repository workingCopy packages do: [ :aPackage | aPackage load ]
```

