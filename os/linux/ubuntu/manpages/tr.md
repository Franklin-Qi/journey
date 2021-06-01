# tr solutions

## Lowercase to uppercase
cat /etc/issue |tr [a-z] [A-Z] > /tmp/issue.out

## Summing 1 to 100
Echo {1..100} |tr ' ' '+'|bc
