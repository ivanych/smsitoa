#!/usr/bin/perl

use strict;

# СМСка
my $sms;

while (<>) {
    #print "str: ",$_;
    
    # Собираем СМСку из строк
    $sms .= $_;
    
    # Если строка заканчивается не кавычкой, то это не конец СМСки и нужно читать следующую строку
    if ($_ !~ /"$/) {
        #print "BREAK!\n";
        next;
    };

    #print "sms: ", $sms;

    # Нужные поля (адрес, дата, текст, флаг)
    my ($a, $d, $t, $f) = $sms =~ /^"\d+","(.*?)","(.*?)","(.*?)","(\d)"/s;
    #print "val: $a, $d, $t, $f\n";

    # Если поля не найдены - СМСка неправильная, переходим к следующей
    unless ($a, $d, $t, $f) {
        #print "INVALID!\n";
        undef $sms;
        next;
    };

    # Конвертируем дату
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($d);
    $year += 1900;
    $mon +=1;
    $mon = "0$mon" if $mon <10;
    $mday = "0$mday" if $mday <10;
    $hour = "0$hour" if $hour <10;
    $min = "0$min" if $min <10;
    $sec = "0$sec" if $sec <10;

    # Конвертируем флаг
    my $q;
    ($f == 2) ? ($q = 'in') : ($q = 'out');

    # Вывод результата
    #print "res: ";
    print qq{"$year-$mon-$mday","$hour:$min:$sec","$q","$a","","$t"\n};

    # С глаз долой, из сердца вон
    undef $sms;
};
