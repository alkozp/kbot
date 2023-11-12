#kbot

An application for interacting with a telegram bot and providing the user with the necessary information

##Usage

Building application with command
`go build -ldflags "-X="github.com/alkozp/kbot/cmd.appVersion={new_version}`

Start application:
* use `./kbot.exe start` for Windows  
* use `kbot start` for Linux

Used following bot in Telegram [https://t.me/alkozp_kbot](https://t.me/alkozp_kbot)

###Available commands in application
* `help`- return list of used commands
* `version` - return current version kbot


###Available commands in Telegram
* `hello` - return current version kbot
* `time` - return current date/time in full format

