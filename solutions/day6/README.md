Day 6
---

Refactoring helps `=)`


`time sh day6-2.sh && time sh day6-2-refactor.sh && time sh day6-2-refactoragain.sh && time sh day6-2-finalrefactor.sh >> README.md`

Results:
```
# Dumb approach
Sum of counts: 3358
real    0m 36.93s
user    0m 38.94s
sys     0m 12.24s
# Reduce number of loops
Sum of counts: 3358
real    0m 21.86s
user    0m 27.36s
sys     0m 4.66s
# Switch from sed to cut - this was slower!
Sum of counts: 3358
real    0m 30.58s
user    0m 38.21s
sys     0m 6.30s
# scrap as many loops as possible and operate only on complete groups
Sum of counts: 3358
real    0m 1.41s
user    0m 2.49s
sys     0m 0.28s
```
