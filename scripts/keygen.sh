#!/usr/bin/env bash

ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -P ""
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan localhost >> /home/vagrant/.ssh/known_hosts
ssh-keyscan 0.0.0.0 >> /home/vagrant/.ssh/known_hosts

sudo chown -R vagrant:vagrant /home/vagrant/.ssh/
