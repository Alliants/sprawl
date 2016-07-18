# Sprawl - Nobody has ever seen him, but he's important

Sprawl works as a notification broadcasting mechanism of the TopGun project.

## Pre-requisites

* Redis

## Installation

`git clone git@github.com:Alliants/goose-server.git`

`bundle`

## To Run locally

`bundle exec foreman start`

visit

[http://localhost:9292/health](http://localhost:9292/health)

## Basic usage

### Configuration
Sprawl uses a list of services that needs to be notified to know where messages
need to be broadcasted to. This list is configured by environment and you can
find it in `./config/subscribers.[env].yml`

The usual structure is as follows:

```
- "http://example1.com"
- "https://example2.com"
```

### Sending notifications

To broadcast a notification to all subscribers, the only thin that needs to be
done is do a POST request to `/notification` with a `payload` that contains the message to be
broadcasted to the sprawl service.

The mechanism is fire and forget, so there is not way to determine if the
message was received by all the consumers. Sprawl will return `message received`
once the message has been queued for delivery.

Example:

```
$ curl -X POST -d 'payload={"username":"xyz","password":"xyz"}' http://localhost:9292/notification
```

### Receiving notifications
The services that need to be notified need to follow a certain structure to be
able to receive notifications. The convention is to implement a `/notification`
endpoint that accepts POST.

An example message will be in json format and will look like the following:

```
{
  "source"=>"www.source.com", # Originator of the message
  "message"=>content_sent_from_source # original content sent
}
```
