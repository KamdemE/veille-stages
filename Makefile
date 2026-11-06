.DEFAULT_GOAL := help
# NOTE: no top-level $(shell git ...) in recipes (would pollute .git/ under sudo make).
# Use inline $$(...) inside recipes only.

help:  ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

push:  ## Push current branch to all remotes
	@branch="$$(git branch --show-current)"; \
	for remote in $$(git remote); do \
		echo "==> pushing $$branch to $$remote"; \
		git push "$$remote" "$$branch"; \
	done

push-tags:  ## Push all tags to all remotes
	@for remote in $$(git remote); do git push "$$remote" --tags; done

git-status:  ## git status --short
	@git status --short
