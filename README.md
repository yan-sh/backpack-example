## Nix unable to build this project

### TL;DR

```sh
; cabal build example # this works
; nix build # and this doesn't
```

### More details

Relevant log lines are these:
```
backpack-example> Configured component graph:
backpack-example>     component backpack-example-0.1.0.0-4uBeI26AlJvGgFX6gH8ykZ-example
backpack-example>         include usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk (UseCases as UseCasesProd) requires (Sig as Prod)
backpack-example>         include usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk (UseCases as UseCasesTest) requires (Sig as Test)
backpack-example>         include base-4.17.2.1
backpack-example>         include models-0.1.0.0-GN1tu1jmhWS1wcH1kyjG0v
backpack-example>         include prod-impl-0.1.0.0-Humlg6k74KnNlb22dNlK
backpack-example>         include test-impl-0.1.0.0-9kOCgyH8veb4cu5u9DCcP5
backpack-example>         include text-2.0.2
backpack-example>         include transformers-0.5.6.2
backpack-example> Linked component graph:
backpack-example>     unit backpack-example-0.1.0.0-4uBeI26AlJvGgFX6gH8ykZ-example
backpack-example>         include usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk[Sig=prod-impl-0.1.0.0-Humlg6k74KnNlb22dNlK:Prod] (UseCases as UseCasesProd)
backpack-example>         include usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk[Sig=test-impl-0.1.0.0-9kOCgyH8veb4cu5u9DCcP5:Test] (UseCases as UseCasesTest)
backpack-example>         include base-4.17.2.1
backpack-example>         include models-0.1.0.0-GN1tu1jmhWS1wcH1kyjG0v
backpack-example>         include prod-impl-0.1.0.0-Humlg6k74KnNlb22dNlK
backpack-example>         include test-impl-0.1.0.0-9kOCgyH8veb4cu5u9DCcP5
backpack-example>         include text-2.0.2
backpack-example>         include transformers-0.5.6.2
backpack-example> Ready component graph:
backpack-example>     definite backpack-example-0.1.0.0-4uBeI26AlJvGgFX6gH8ykZ-example
backpack-example>         depends usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk+HmuJpHdlfEf8oysLgJukXT
backpack-example>         depends usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk+2LaAp81Wiae4Eg7a6Ly1n6
backpack-example>         depends base-4.17.2.1
backpack-example>         depends models-0.1.0.0-GN1tu1jmhWS1wcH1kyjG0v
backpack-example>         depends prod-impl-0.1.0.0-Humlg6k74KnNlb22dNlK
backpack-example>         depends test-impl-0.1.0.0-9kOCgyH8veb4cu5u9DCcP5
backpack-example>         depends text-2.0.2
backpack-example>         depends transformers-0.5.6.2
backpack-example> CallStack (from HasCallStack):
backpack-example>   withMetadata, called at libraries/Cabal/Cabal/src/Distribution/Simple/Utils.hs:370:14 in Cabal-3.8.1.0:Distribution.Simple.Utils
backpack-example> Error:
backpack-example>     The following packages are broken because other packages they depend on are missing. These broken packages must be rebuilt before they can be used.
backpack-example> planned package backpack-example-0.1.0.0 is broken due to missing package usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk+HmuJpHdlfEf8oysLgJukXT, usecases-0.1.0.0-5NHgpQ3vXSl10aldH4TzAk+2LaAp81Wiae4Eg7a6Ly1n6
```

As I understand this text, lines `usecases-0.1.0.0-5NHg...[Sig=prod-impl-0.1.0.0-Huml...:Prod] (UseCases as UseCasesProd)` from the linked component graph are replaced by `usecases-0.1.0.0-5NHg...+HmuJ...` in the ready component graph, and then Cabal library informs us that this package does not exist. Notice that additional hash in ready graph doesn't match the original hash of `prod-impl`.
