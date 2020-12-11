all:
	swift build

release:
	swift build -c release

run:
	./.build/x86_64-apple-macosx/debug/chaos-game

clean:
	rm -rf .build/
