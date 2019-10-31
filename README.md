# PuzzleGame

## Something I learned during refactoring

+ Upgrading from swift 2 to 5 for such a small code base only need less than a mintue.
+ Refactoring reduce a lot of code, code become more simple.
+ Without any 3rd framework dependencies, from iOS to Catalyst just two checkbox away.
+ Avoid signing cgColor to layer properties, they don't support dark mode at all.
+ If you go with Storyboard, Embed in View is your friend, it makes layout dead simple.
+ Even in Storyboard, watch out for violating DRY principle. If there's many copies of @IBDesignable views, and most of them have the same appearance, move the appearance logic into source code.
+ Global constant (let alone variable!) is bad, you can do better.
+ Every crash on force unwrapped nil is an opportunity to change the function's return type to Optional and apply guard against its assignment.

I created this project in October 10, 2016, while I was looking for a job, three days later I got my first job, thus this project always has a special meaning to me.

