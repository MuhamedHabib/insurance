# Official repository of SociaLinker, an AI-powered social networks scraper and leads generation tool.

## Without Docker Compose

Apply migrations:
```bash
python manage.py migrate --noinput
```
Development
```bash 
python manage.py runserver 0.0.0.0:8000
```
Production: gunicorn (Linux only)
```bash 
python manage.py collectstatic --noinput
gunicorn socialinker.wsgi:application --bind 0.0.0.0:8000
```
Production: daphne
```bash 
python manage.py collectstatic --noinput
daphne -b 0.0.0.0 -p 8000 socialinker.asgi:application
```
Redis:

Redis is necessary for real-time notifications and background tasks.

There are 2 methods to run Redis:

Method 1: Using WSL2
- Install WSL2
- Install Ubuntu for Windows from Windows Store
- Launch Ubuntu for Windows and type the following:
```bash
redis-server
```
Method 2: Using Docker
```bash
docker run --name redis -d -p 6379:6379 redis
```
RabbitMQ (Optional):

RabbitMQ can be used as an alternative for Redis to run background tasks.

Using Docker:
```bash
docker run -d -p 5672:5672 --name rabbitmq rabbitmq
```
Celery:
```bash
set DJANGO_SETTINGS_MODULE=socialinker.settings
celery -A socialapp worker --loglevel=INFO --without-gossip -P threads
```
Celery beat:
```bash
set DJANGO_SETTINGS_MODULE=socialinker.settings
celery -A socialapp beat --loglevel=INFO -S redbeat.RedBeatScheduler
```
Celery flower:
```bash 
celery --broker=redis://localhost:6379/1 flower ### Redis (default)
celery --broker=amqp://guest:guest@localhost:5672// flower ### RabbitMQ
```
Then navigate to localhost:5555 to monitor tasks

## Using Docker Compose

Coming soon

## Using Kubernetes

Coming soon
