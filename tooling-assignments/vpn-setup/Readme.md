# Cluster Access Setup Tutorial

This is a short description of the tools we need to setup

## Configure VPN

If you are off of the campus network, connect via the university VPN client to our internal network. You can download the VPN client at [https://vpn-1.iit.edu](https://vpn-1.iit.edu "webpage for the VPN download") for MacOS and Windows (autodetects). 


![*VPN Login*](./images/vpn.png "image for displaying vpn login")

Use your full `@hawk.illinoistech.edu` email and portal password to authenticate. You will have to 2-factor authenticate as well.

## Connect to VPN

Launch the Cisco VPN tool and connect to `vpn.iit.edu` 

![*VPN Connect*](./images/vpn-iit-edu.png "image of connection URL")

Authenticate using your Portal username and password

![*VPN Authentication*](./images/auth.png "image of correct authentication")

Watch out! The two-factor message triggers quickly and doesn't have much patience, make sure to have your phone ready to approve the connection.

If you have more than one MFA set up besides your phone, it could give you a tricky time. If it is not prompting you to input one of your MFA, then close it, reconnect, and try putting `,SMS` directly after your password (no spaces and caps). For example if your password is `ilovebunnies`: `ilovebunnies,SMS`.

## Test Connection

Once the VPN is succesfully connected, you can test this connection by opening up a Terminal and issuing a `ping` command:

```bash
ping 192.168.192.2
```

Results:

![*Ping Success*](./images/ping-success.png "Ping S")
