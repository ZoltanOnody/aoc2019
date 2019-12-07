# Day 7

Wow, another problem which requires me to reuse some old code. I am sure as hell I am not going to rewrite it to another language (again).

Let's modify the solution from day 5.

```
diff --git a/day5/problem.php b/day5/problem.php
index b9e6c48..f4fd813 100644
--- a/day5/problem.php
+++ b/day5/problem.php
@@ -1,7 +1,7 @@
 <?php
 
-function interpret($bytecode) {
-       $memory = array_map('intval', explode(",", $bytecode));
+function interpret($reader) {
+       $memory = array_map('intval', explode(",", $reader()));
        $pointer = 0;
 
        while (true) {
@@ -25,7 +25,7 @@ function interpret($bytecode) {
                                $pointer += 4;
                                break;
                        case 3:
-                               $memory[$index1] = intval(readline());
+                               $memory[$index1] = intval($reader());
                                $pointer += 2;
                                break;
                        case 4:
@@ -55,4 +55,18 @@ function interpret($bytecode) {
        }
 }
 
-interpret(readline());
+
+if (isset($_GET['stdin'])) {
+       // Execute via HTTP request.
+       $index = 0;
+       $input = explode(";", $_GET['stdin']);
+
+       $mockedSTDIN = function() use ($input, &$index) {
+               return $input[$index++];
+       };
+
+       interpret($mockedSTDIN);
+} else {
+       // Execute directly using `php problem.php`
+       interpret('readline');
+}
```

This way if I just run `php problem.php` the code runs as before, but if I make a HTTP request, the input is read from a parameter.

So let's fire up a simple HTTP server `docker run -v $(pwd):/devhome -p 8080:8080 -it php:7 php -S 0.0.0.0:8080` from `day5` directory and let's test the API.

Making a HTTP request:

```
http://localhost:8080/devhome/problem.php?stdin=3,8,1001,8,10,8,105,1,0,0,21,34,51,76,101,126,207,288,369,450,99999,3,9,102,4,9,9,1001,9,2,9,4,9,99,3,9,1001,9,2,9,1002,9,3,9,101,3,9,9,4,9,99,3,9,102,5,9,9,1001,9,2,9,102,2,9,9,101,3,9,9,1002,9,2,9,4,9,99,3,9,101,5,9,9,102,5,9,9,1001,9,2,9,102,3,9,9,1001,9,3,9,4,9,99,3,9,101,2,9,9,1002,9,5,9,1001,9,5,9,1002,9,4,9,101,5,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99;1
```

returns `9` as expected.


The solution itself seems easy enough so I'll write in in perl. I've never written (and probably never read) a single line of perl in my life, so this one will require a little bit more of a preparetion.



## Resources
- https://www.php.net/manual/en/class.closure.php#117469
- https://stackoverflow.com/questions/2700433/accept-function-as-parameter-in-php
- https://stackoverflow.com/a/11222247
- https://perldoc.perl.org/perlintro.html#Conditional-and-looping-constructs
