<?php
// /var/www/html/good.php

function good_message($name) {
    return "Good job, " . $name . "!";
}

function good_score($base, $bonus) {
    return $base + $bonus;
}

class GoodChecker {
    public function validate($value) {
        return $value > 0;
    }
}
