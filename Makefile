# Don't actually write files to prodution.
ifndef DRYRUN
  DRYRUN=
else
  DRYRUN=--dryrun
endif

SRCDIR=./src
SRCVIDEODIR=./src-video
DISTDIR=./dist
APPLINKSFILE=.well-known/apple-app-site-association

deploy: build upload

clean:
	rm -rf ${DISTDIR}

dist:
	mkdir dist

build: dist
	npm run build

dev:
	npm run dev

AWS_PROFILE=recentralized-org
AWS_S3_BUCKET=www.seriesphotos.app

config-aws:
	aws configure --profile=$(AWS_PROFILE)

upload:
	aws s3 sync --profile=$(AWS_PROFILE) $(DRYRUN) --delete --exclude=video/hls/* $(DISTDIR) s3://$(AWS_S3_BUCKET)/
	aws s3 cp --profile=$(AWS_PROFILE) $(DRYRUN) --content-type='application/json' $(DISTDIR)/${APPLINKSFILE} s3://$(AWS_S3_BUCKET)/${APPLINKSFILE}

clean_remote:
	aws s3 rm --profile=$(AWS_PROFILE) $(DRYRUN) --recursive s3://$(AWS_S3_BUCKET)/

create_hls:
	mkdir -p ${DISTDIR}/video/hls/QuickStart
	mediafilesegmenter -f ${DISTDIR}/video/hls/quick-start ${SRCVIDEODIR}/Quick\ Start\ App\ Low.mp4
	# Beta 189 accidentally used this path
	mediafilesegmenter -f ${DISTDIR}/video/hls/QuickStart ${SRCVIDEODIR}/Quick\ Start\ App\ Low.mp4

upload_hls: create_hls
	aws s3 sync --profile=$(AWS_PROFILE) $(DRYRUN) ${DISTDIR}/video/hls s3://$(AWS_S3_BUCKET)/video/hls
