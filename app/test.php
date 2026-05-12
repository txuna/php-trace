<?php
// /var/www/html/test.php

require_once __DIR__ . '/good.php';

function add($a, $b) {
    return $a + $b;
}

function greet($name) {
    return "Hello, " . $name . "!";
}

function outer() {
    return inner();
}

function inner() {
    return "inner result";
}

class Calculator {
    public function multiply($a, $b) {
        return $a * $b;
    }
}

function fib($n) {
    if ($n <= 1) return $n;
    return fib($n - 1) + fib($n - 2);
}

// 실행
$result = add(3, 4);
echo "add(3,4) = $result\n";

$msg = greet("World");
echo "$msg\n";

echo "outer() = " . outer() . "\n";

$calc = new Calculator();
echo "multiply(6, 7) = " . $calc->multiply(6, 7) . "\n";

echo "fib(3) = " . fib(3) . "\n";

// good.php 호출
echo good_message("PHP") . "\n";
echo "score = " . good_score(80, 20) . "\n";

$checker = new GoodChecker();
echo "validate(42) = " . ($checker->validate(42) ? "true" : "false") . "\n";