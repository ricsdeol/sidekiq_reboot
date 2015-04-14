# Sidekiq Reboot
Dummy Sidekiq Startup after reboot.

Not tested yet. Testing in production :suspect:.


## Config

Put in your /etc/rc.local.

```bash
su [user] -c 'sleep 120 && [path_to]/sidekiq_start.rb >> [path_log]/sidekiq_start.log'
```
