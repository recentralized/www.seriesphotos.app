# Don't actually write files to prodution.
ifndef DRYRUN
  DRYRUN=
else
  DRYRUN=--dryrun
endif

SRCDIR=./src
DISTDIR=./dist

deploy: build upload

dist:
	mkdir dist

build: dist
	cp -r ${SRCDIR}/* ${DISTDIR}

dev:
	cd $(SRCDIR) && python -m SimpleHTTPServer 4000

# Deployment to AWS
AWS_PROFILE=recentralized-org
AWS_S3_BUCKET=www.seriesphotos.app

# Configure the AWS tool.
config-aws:
	aws configure --profile=$(AWS_PROFILE)

# Sync everything, ignoring the /archives dir.
upload:
	aws s3 sync --profile=$(AWS_PROFILE) $(DRYRUN) --delete $(DISTDIR) s3://$(AWS_S3_BUCKET)/

# Remove everything from the s3 bucket.
clean_remote:
	aws s3 rm --profile=$(AWS_PROFILE) $(DRYRUN) --recursive s3://$(AWS_S3_BUCKET)/

