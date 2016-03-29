
# To run
```shell
rackup config.ru --host 0.0.0.0 --port 8080
rake scss:watch
browser-sync start --proxy 0.0.0.0:8080 --files "public/css/**/*.css, views/*.erb"
```

We can add the `--tunnel` option to browser-synch to get an external URL for sharing with others.


### Available Helper Classes

`.u-disable-hover` - Disables the pointer on hover
`.u-hidden` - Hides the element
`.u-visuallyhidden` - Hides the element, but retains visibility to screen readers
`.u-clearfix` - Clearfix
`.u-pad` - Adds 1rem padding all round
`.u-csl` - Contains standard Links. All links in this element will be formatted as if on a white background.
`.pp` - Only works on `<code>` tags, highlights the code.
`ul.inline` - Forces a list inline.
`.tag` - displays a tag
`.badge` - displays a badge
`.btn` - displays a button
`.btn .btn-small` - displays a smaller button. Adding a disabled class or a pressed class correctly triggers the assocuated styles.

Tables are styled automaticallt, but applying a class of `left` to a th or td will left-align the text.

### Components

`.c-meter`
`ul.c-leader`
`c-topbar`
`c-breadcrumbs` - must also have `inline` and `u-clearfix` classes applied to work correctly.

## Cards





