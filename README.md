Go to project directory and run:

`bundle`

`rails s`

Root path shows current status:

[http://localhost:3000](http://localhost:3000)

Upload coins (parameter key is coin's value, parameter value is amount).
For example 10 coins with value 50 and 5 coins with value 25 will be:

[http://localhost:3000/create?50=10&25=5](http://localhost:3000/create?50=10&25=5)

Add coins works same way, just use update path instead of create:

[http://localhost:3000/update?50=10&25=5](http://localhost:3000/update?50=10&25=5)

To exchange money go to exchange path and pass amount parameter with value.
Value is a number in coins. For example:
- You want 1 uah then amount will be 100
- You want 30 cents then amount will be 30
- You want 3,50 uah then amount will be 350

[http://localhost:3000/exchange?amount=350](http://localhost:3000/exchange?amount=350)
