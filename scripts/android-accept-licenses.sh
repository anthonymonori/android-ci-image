#!/usr/bin/expect -f

# Originally written by Jacek Marchwicki <jacek.marchwicki@gmail.com> and Karol Wojtaszek <karol@appunite.com>, but later placed in the public domain.

set timeout 1800
set cmd [lindex $argv 0]
set licenses [lindex $argv 1]

spawn {*}$cmd
expect {
  "Do you accept the license '*'*" {
        exp_send "y\r"
        exp_continue
  }
  eof
}
