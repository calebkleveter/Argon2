# Argon2

A Swift wrapper for the [Argon 2 hashing algorithm](https://github.com/P-H-C/phc-winner-argon2). Compatible with SPM.

## Libraries

This package has 2 libraries, `Argon2` and `CArgon2`. 

`Argon2` is the Swift layer over the C functions for hashing and verifying byte arrays. It has methods to handle `String` and more Swift-like configurations. This library does not give you access to the C interface.

`CArgon2` is just the C library wrapped in an SPM package. There is no Swift in this library.

## Swift API

### `Error`

The `Argon2.Error` type is used to represent errors that are returned from the underlying hashing and verification functions. It has a `code` property which is the error code of the error returned. You can see a whole list of the possible errors [here](https://github.com/P-H-C/phc-winner-argon2/blob/b31aa322566a8559403d419b2e9cd3f57957e394/include/argon2.h#L100).

The success code of a function is `0`, while all errors are negative numbers. If a positive error code is returned, is was from the Swift API, not the C library.

For an easy PR, you could create static cases for the `Error` struct that match the errors in the C library.

### `HashMode`

`HashMode` is an enum where the cases represent the possible hashing processes that a byte array can be sent through. There are `i`, `d`, and `id`. There are documentation comments for these cases about their differences.

There are also two properties. `method`, which is the hashing function for that hashing mode, and `verify`, which is the verification function for that mode.

### `Context`

This is a struct that holds configuration information for hashing a byte array. The original Argon 2 repo didn't have any documentation on these values that I found, so I wrote some very vague API docs for the properties.

There is a `default` static property that gets you an instance to pass into the hasher. The value for the properties where pulled from the example in the original repo's README.

### `Argon2`

The main type of the repo, `Argon2` does not have any public initializers or properties. Instead it has static methods that can be called to hash and verify byte arrays or strings.   

## License

This repo is under the [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) license.
