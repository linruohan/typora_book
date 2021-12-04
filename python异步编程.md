# python异步编程之 async await

本文代码采用python3.6运行.

## 发展史

```
- 3.3: The yield from expression allows for generator delegation.
- 3.4: asyncio was introduced in the Python standard library with provisional API status.
- 3.5: async and await became a part of the Python grammar, used to signify and wait on coroutines. They were not yet reserved keywords. (You could still define functions or variables named async and await.)
- 3.6: Asynchronous generators and asynchronous comprehensions were introduced. The API of asyncio was declared stable rather than provisional.
- 3.7: async and await became reserved keywords. (They cannot be used as identifiers.) They are intended to replace the asyncio.coroutine() decorator. asyncio.run() was introduced to the asyncio package, among a bunch of other features.
```

本质上是使用了协程,当调用await时让渡CPU,有结果返回时再切换回来.相比使用回调来协调执行顺序来说,await编程方式在每个协程中代码是顺序执行的,对代码编写来说更为友好.

## 语法

### async def

调用一个async func返回了什么?

```python
async def fun1():
    return

async def fun2():
    yield

print(type(fun1()))
print(type(fun2()))

# <class 'coroutine'>
# <class 'async_generator'>
```

### await

- await只能用于async函数中

  ```python
  async def f(x):
      y = await z(x)  # OK - `await` and `return` allowed in coroutines
      return y
  
  async def g(x):
      yield x  # OK - this is an async generator
  
  async def m(x):
      yield from gen(x)  # No - SyntaxError
  
  def m(x):
      y = await z(x)  # Still no - SyntaxError (no `async def` here)
      return y
  ```

- await后面只能跟一个awaitable对象(一般情况下是一个Coroutine对象)

### 调用(启用)方式

```python
import time
import asyncio


async def coro(seq) -> list:
    """'IO' wait time is proportional to the max element."""
    await asyncio.sleep(max(seq))
    return list(reversed(seq))


async def main():
    """
    ensure_future():创建任务,Python 3.7+后被create_task()取代.
    t.done(): 返回任务执行状态:Bool类型.

    执行结果:
    ------------------------------------------
    t: type <class '_asyncio.Task'>
    t done: False
    t result: [1, 2, 3]
    t done: True
    ------------------------------------------
    """
    # t = asyncio.create_task(coro([3, 2, 1]))  # Python 3.7+
    t = asyncio.ensure_future(coro([3, 2, 1]))  # Python 3.*

    print(f't: type {type(t)}')
    print(f't done: {t.done()}')
    a = await t
    print(f't result: {a}')
    print(f't done: {t.done()}')

async def main2():
    """
    tasks = gather():收集多个任务
    await tasks:任务全部完成一起返回

    执行结果:
    ------------------------------------------
    Start: 11:11:29
    [[1, 2, 3], [0, 5, 6]]
    End: 11:11:35
    Both tasks done: True
    ------------------------------------------
    """
    t = asyncio.ensure_future(coro([3, 2, 1]))
    t2 = asyncio.ensure_future(coro([6, 5, 0]))
    print('Start:', time.strftime('%X'))
    a = await asyncio.gather(t, t2)
    print(a)
    print('End:', time.strftime('%X'))  # Should be 10 seconds
    print(f'Both tasks done: {all((t.done(), t2.done()))}')


async def main3():
    """
    as_completed 每个任务完成即返回该任务的结果.

    执行结果:
    ------------------------------------------
    Start: 11:08:13
    res: [1, 2, 3] completed at 11:08:16
    # 三秒后
    res: [0, 5, 6] completed at 11:08:19
    End: 11:08:19
    Both tasks done: True
    ------------------------------------------

    """
    t = asyncio.ensure_future(coro([3, 2, 1]))
    t2 = asyncio.ensure_future(coro([6, 5, 0]))
    print('Start:', time.strftime('%X'))
    for res in asyncio.as_completed((t, t2)):
        compl = await res
        print(f'res: {compl} completed at {time.strftime("%X")}')
    print('End:', time.strftime('%X'))
    print(f'Both tasks done: {all((t.done(), t2.done()))}')


if __name__ == '__main__':
    # python < 3.7
    loop = asyncio.get_event_loop()
    # loop.run_until_complete(main())
    # loop.run_until_complete(main2())
    loop.run_until_complete(main3())
    loop.close()

    # python 3.7
    # asyncio.run(main())
```

## DEMO

### 并发http请求

该Demo使用[aiohttp](https://aiohttp.readthedocs.io/)发送异步请求.

```python
"""
并发爬取36kr数据,并保存为本地文件
"""
import asyncio
import aiohttp
import json


async def get_json(client, url):
    async with client.get(url) as response:
        assert response.status == 200
        return await response.read()


async def get_36_kr(page, client):
    data1 = await get_json(client, 'https://36kr.com/api/search-column/mainsite?per_page=20&page={}'.format(page))
    j = json.loads(data1.decode('utf-8'))

    with open(f"./content/{page}.json", "w", encoding='utf-8') as f:
        f.write(json.dumps(j, indent=2, ensure_ascii=False))

    print('Done with page:', page)


async def main():
    client = aiohttp.ClientSession(loop=loop)
    tasks = [asyncio.ensure_future(get_36_kr(i, client)) for i in range(100)]
    await asyncio.gather(*tasks)
    await client.close()

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
    loop.close()
```

### 精简下(需python3.7下运行)

```python
import asyncio
import aiohttp
import json


async def get_36_kr(page, client):
    url = f'https://36kr.com/api/search-column/mainsite?per_page=1&page={page}'
    async with client.get(url, ssl=False) as response:
        assert response.status == 200
        return await response.json()


async def main():
    async with aiohttp.ClientSession() as client:
        tasks = [asyncio.ensure_future(get_36_kr(i, client))
                 for i in range(2)]
        res = await asyncio.gather(*tasks)
        print(json.dumps(res,indent=2))

if __name__ == '__main__':
    asyncio.run(main())
```

## 异步IO库

async/await可使用的库.

- From aio-libs:
  - aiohttp: Asynchronous HTTP client/server framework
  - aioredis: Async IO Redis support
  - aiopg: Async IO PostgreSQL support
  - aiomcache: Async IO memcached client
  - aiokafka: Async IO Kafka client
  - aiozmq: Async IO ZeroMQ support
  - aiojobs: Jobs scheduler for managing background tasks
  - async_lru: Simple LRU cache for async IO
- From magicstack:
  - uvloop: Ultra fast async IO event loop
  - asyncpg: (Also very fast) async IO PostgreSQL support
- From other hosts:
  - trio: Friendlier asyncio intended to showcase a radically simpler design
  - aiofiles: Async file IO
  - asks: Async requests-like http library
  - asyncio-redis: Async IO Redis support
  - aioprocessing: Integrates multiprocessing module with asyncio
  - umongo: Async IO MongoDB client
  - unsync: Unsynchronize asyncio
  - aiostream: Like itertools, but async

标签: [python 异步 async await](https://www.cnblogs.com/aloe-n/tag/python 异步 async await/)