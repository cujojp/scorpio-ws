Scorpio Web Service
=======================

A web service for people to check their all important scores. 
Why does this exists? Because we at Globex Corporation care about you!

- Presentations

- Staging

## Getting started

This is running using frappe which is a skeleton template using Express written in Coffeescript. 
For scaffolding and layout the application is based on a skeleton version of Gumby. 

### Check Dependencies

To check if you have node.js installed.
            
### Start

To start the server:
```sh
$ npm start
```

For convenience while developing, automatic restarts are provided with:
```sh
$ cake start
```

Additionally, the port and environment variables can be set. The following
example will start the server listening on port 3000 in production mode:
```sh
$ cake -p 3000 -e production start
```

_## Setting up Dokku

### Setting up your SSH Keys
`sh
cat ~/.ssh/id_rsa.pub | ssh root@scorpio.cujo.jp "sudo sshcommand acl-add dokku scorpio"
`

### Sync your git account with your Dokku VPS for easy deployments 
`sh
git remote add dokku root@scorpio.cujo.jp:scorpio-ws
`
Current VPS password: npiitkdudgvy

### Deploy to Dokku
`sh
$ ssh root@scorpio.cujo.jp
`

Watch it run and it will eventually deploy to the server URL listed within the logs.

Now would also be a good time to check if your deployment was successful at all. Most of the time when something has gone wrong when connecting to the URL it will display a simple 502 nginx error. You can check the logs of the process by SSH'ing into the VPS.

## SSH Into the VPS
To run the server, check logs and other fun things, we will need to SSH into our VPS to do so run the following command (make sure you have your SSH keys uploaded to digital ocean):

`sh
$ ssh root@scorpio.cujo.jp
`

Enter the VPS password which was listed earlier. 

## Oh no! It's not running.

To debug the app on the digital ocean server you can ssh into the VPS and run 
`sh
$ docker ps -a
` 

Then find the container Id which has failed, usually will contain an Exit with an error code. 

`sh
$ docker logs [container id]
`

There you will see the logs from the container and will include a stack error from your failed module. 

Have fun debugging!

### Error: Cannot find module '_______'
Your node modules did not successfully install via Dokku (typical). We will more than likely need to install the modules manually or try deploying to dokku again.
_
