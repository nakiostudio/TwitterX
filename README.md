# TwitterX

A desperate attempt of keeping Twitter for macOS alive.

The aim of this project is as humble as maintaining the application working while adding
some small features. All this, by injecting code into the official binary.

## Give it a try

I would like to create a macOS application to easily patch the original Twitter binary,
for now and for devs only, compile the `TwitterX.framework` and inject the library to
the Twitter process as follows:

```shell
DYLD_INSERT_LIBRARIES="TwitterX.framework/Versions/A/TwitterX" /Applications/Twitter.app/Contents/MacOS/Twitter &
```

## Features added

<table width="100%">
<tr>
<td width="50%">
Rounded avatars
</td>
<td width="50%">
Increased chars limit to 280
</td>
</tr>
<tr>
<td width="50%">
<img src="/README/rounded_avatars.png" width="100%"/>
</td>
<td width="50%">
<img src="/README/chars_limit.png" width="100%"/>
</td>
</tr>
<tr>
<td width="50%">
New light theme
</td>
<td width="50%">
Fixed full-screen mode
</td>
</tr>
<tr>
<td width="50%">
<img src="/README/light_theme.png" width="100%"/>
</td>
<td width="50%">
<img src="/README/full_screen_fix.png" width="100%"/>
</td>
</tr>
</table>

## Contributing

Help is wanted and appreciated in the form of Pull Requests or Issues creation.

## Author

[Carlos Vidal](https://www.twitter.com/carlostify)

