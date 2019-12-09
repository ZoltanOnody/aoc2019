# Day 5

The solution for Day 5 is written in `php`. To prevent that "virus" running on my computer, I'll work inside a docker container (`docker run -v $(pwd):/devhome -it php:7 bash`).

## Build docker image
```
docker build -f build/Dockerfile . -t aoc-day5
```

## Running tests
```
docker run -it aoc-day5 ./vendor/bin/phpunit tests
```

## Resources
- https://www.php.net/manual/en/function.array-map.php
- https://www.php.net/manual/en/function.intval.php
- https://www.php.net/manual/en/function.print-r.php
- https://www.php.net/manual/en/control-structures.switch.php
