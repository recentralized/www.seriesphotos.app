# Don't actually write files to prodution.
ifndef DRYRUN
  DRYRUN=
else
  DRYRUN=--dryrun
endif

SRCDIR=./src
DOCSDIR=./tailwindui-syntax
DISTDIR=./dist

deploy: build upload

clean:
	rm -rf ${DISTDIR}

dist:
	mkdir dist

build: dist
	cp -r ${SRCDIR}/* ${DISTDIR}
	cd ${DOCSDIR} && npm run export
	cp -r ${DOCSDIR}/out ${DISTDIR}/docs
	cp -r ${DOCSDIR}/out/fonts/* ${DISTDIR}/fonts
	mv ${DISTDIR}/docs/docs/* ${DISTDIR}/docs
	rm -rf ${DISTDIR}/docs/docs

dev:
	cd $(SRCDIR) && python -m SimpleHTTPServer 4000

AWS_PROFILE=recentralized-org
AWS_S3_BUCKET=www.seriesphotos.app

config-aws:
	aws configure --profile=$(AWS_PROFILE)

upload:
	aws s3 sync --profile=$(AWS_PROFILE) $(DRYRUN) --delete $(DISTDIR) s3://$(AWS_S3_BUCKET)/

clean_remote:
	aws s3 rm --profile=$(AWS_PROFILE) $(DRYRUN) --recursive s3://$(AWS_S3_BUCKET)/

