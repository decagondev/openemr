<?php
//  OpenEMR
//  MySQL Config

$host   = 'openemr-db';
$port   = '3306';
$login  = 'openemr';
$pass   = 'SuperSecureUserPass456!';
$dbase  = 'openemr';

$sqlconf = array();
global $sqlconf;
$sqlconf["host"]= $host;
$sqlconf["port"] = $port;
$sqlconf["login"] = $login;
$sqlconf["pass"] = $pass;
$sqlconf["dbase"] = $dbase;

//////////////////////////
//////////////////////////
//////////////////////////
//////DO NOT TOUCH THIS///
$config = 1; /////////////
//////////////////////////
//////////////////////////
//////////////////////////
?>
