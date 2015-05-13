# Common Problems

1. Namespace Collision

```
This binding for ‘text’ shadows the existing binding imported from ‘Text.Blaze’ at WhateverModule.hs (and originally defined in ‘Text.Blaze.Internal’)
```

This simply means that the variable 'text' that I am declaring in my program collides with a function or declaration already in use by a module that I am importing. In this case, the `blaze-html` package.
