<?php

function write(string $name): string {
    $name = strtoupper($name);
    return $name;
}

echo write("hello") . "\n";