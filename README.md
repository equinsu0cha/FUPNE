# FUPNE
Facebook User Phone Number Enumerator

Facebook decieded sometime ago to set the default security permssions for users to allow anyone to access their phone number. Combined with the insecure and lack of thought towards privacy, with a litle nmcli magic, one can enumerate literally millions of phone number to the person that owns them.

You will need to have vpns setup through network-manager to have the ip refresh work right. It is probably important that you save the VPN user/pass in network manager or you will get prompted each switch.

Second number of last 4 need to be -gt that the first obviously. I was too busy to write some test logic in to test. One IP will harvest about 20-50 tries before you get capthca'd. The IP capthca only lasts for a min or two, so you could do this wth perhaps as little as 3 or 4 vpns.

Master log will keep all findings in a json format.

Its important that the phone numb er range choosen is usually that of a mobile exchange. Easy enough to look through for cell numbers you know others have, then run that area code and exhcnage through.

You can do internaltional numbers as well, just adjust the number entered to match the correct calling ex=change of that area.

Good luck!
