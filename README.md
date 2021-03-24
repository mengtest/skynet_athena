## Build

```
git clone https://github.com/fztcjjl/ATHENA.git
cd ATHENA
make
```

## Test
将tools/ATHENA.sql导入到mysql<br />

```
./tools/redis.sh
./tools/startlogin.sh
./tools/startgame.sh
lua client.lua login 80 1
```

##About skynet
[https://github.com/cloudwu/skynet](https://github.com/cloudwu/skynet)<br /> 
