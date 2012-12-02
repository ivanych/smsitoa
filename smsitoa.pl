#!/usr/bin/perl

$sms;

while (<>) {
    #print "str: ",$_;
    
    $sms .= $_;
    
    if ($_ !~ /"$/) {
        #print "BREAK!\n";
        next;
    };

    #print "sms: ", $sms;

    ($a, $d, $t, $f) = $sms =~ /^"\d+","(.*?)","(.*?)","(.*?)","(\d)"/s;
    #print "val: $a, $d, $t, $f\n";

    unless ($a, $d, $t, $f) {
        #print "INVALID!\n";
        undef $sms;
        next;
    };

    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($d);
    $year += 1900;
    $mon +=1;
    $mon = "0$mon" if $mon <10;
    $mday = "0$mday" if $mday <10;
    $hour = "0$hour" if $hour <10;
    $min = "0$min" if $min <10;
    $sec = "0$sec" if $sec <10;
    
    ($f == 2) ? ($q = 'in') : ($q = 'out');

    #print "res: ";
    print qq{"$year-$mon-$mday","$hour:$min:$sec","$q","$a","","$t"\n};

    undef $sms;
};
