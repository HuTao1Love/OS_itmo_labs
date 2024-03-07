#!/bin/bash

touch "emails.lst"

grep -h -o -s -r -E '[[:alnum:]\.\-_]+@[[:alpha:]]+\.[[:alpha:]]+' /etc/* > emails.lst
