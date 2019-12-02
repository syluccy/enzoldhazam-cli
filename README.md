# enzoldhazam-cli
CLI Client for https://www.enzoldhazam.hu

## Usage:

```
[user@host enzoldhazam-cli]$ ./enzoldhazam.sh login
Username: myloginuser
Password: myhiddenpassword
Bathroom thermostat ID: 1.7
...
[user@host enzoldhazam-cli]$ ./enzoldhazam.sh addttemp
Bathroom temperature: 25
...
[user@host enzoldhazam-cli]$ ./enzoldhazam.sh settemp
[user@host enzoldhazam-cli]$
```

## Features:

* Set target temperature for all the managed thermostats individually
* Username, password, thermostat ids will be saved after login to ~/.enzoldhazam/

## Known issues:

* Timer data will be overwritten to empty rules
* Password is stored unencrypted
* Answers from the server are being ignored (failed login, unknown thermostat, etc.)

## Future plans:

I've written this quickly just to show an example how to configure these thermostats from code. I've no further plans to implement more features in the near future. Instead I'll implement a similar module into my home-automation framework. However if you have the time, feel free to contribute.
