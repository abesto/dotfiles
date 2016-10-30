test -d ~/playground/go; and set -x GOPATH ~/playground/go
test -d ~/go; and set -x GOPATH ~/go

if test -n "$GOPATH"
  set -x PATH $PATH $GOPATH/bin
end

test -d /usr/local/opt/go/libexec/bin; and set -x PATH $PATH /usr/local/opt/go/libexec/bin $GOPATH/bin
