
# MISC

# for range
> for i in {0000..1100}; do enfuse -o A$i.jpg $(( 10#$i*2 )).jpg $(( 10#$i*2 +1 )).jpg; done
