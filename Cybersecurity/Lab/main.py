import secrets
import string
import urllib.parse

# 1. functionalitate: aplicatie de password management
systemRandom = secrets.SystemRandom()
passwordLength = systemRandom.randrange(10, 21)
uppercaseLetterPosition = secrets.randbelow(passwordLength)
lowerCaseLetterPosition = secrets.randbelow(passwordLength)
while lowerCaseLetterPosition == uppercaseLetterPosition:
    lowerCaseLetterPosition = secrets.randbelow(passwordLength)
digitPosition = secrets.randbelow(passwordLength)
while digitPosition in [lowerCaseLetterPosition, uppercaseLetterPosition]:
    digitPosition = secrets.randbelow(passwordLength)
symbolPosition = secrets.randbelow(passwordLength)
while symbolPosition in [lowerCaseLetterPosition, uppercaseLetterPosition, digitPosition]:
    symbolPosition = secrets.randbelow(passwordLength)

alphabet = list(string.ascii_lowercase)
symbols = list(".!$@")
digits = list("0123456789")
allOptions = alphabet + symbols + digits
password = ""

for i in range(passwordLength):
    if i == symbolPosition:
        password += secrets.choice(symbols)
    elif i == digitPosition:
        password += secrets.choice(digits)
    elif i == lowerCaseLetterPosition:
        password += secrets.choice(alphabet)
    elif i == uppercaseLetterPosition:
        password += secrets.choice(alphabet).upper()
    else:
        password += secrets.choice(allOptions)

print(password)



# 2. generarea unui URL greu de ghicit pentru resetarea parolei unui utilizator
print(urllib.parse.quote("https://app.ssi.com/token=") + secrets.token_urlsafe(32))

# 3. folositor pentru a pastra identitatea unui utilizator de-a lungul mai multor sesiuni (folosit drept cookie)
print(secrets.token_hex(32))

# 4.
print(secrets.compare_digest("a", "a"))
print(secrets.compare_digest("a", "b"))

# 5.
print("{0:b}".format(secrets.randbits(8 * 100)))

# 6.

import keyring
keyring.set_password("python_test", "user", "pass")
print(keyring.get_password("python_test", "user"))