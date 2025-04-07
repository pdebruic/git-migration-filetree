as yet unclassified
setGithubActionsAndCIFor: package in: directoryPath
	| fileContents file dirPath ciContents ciDir |
	fileContents := 'SmalltalkCISpec {
  #loading : [
    SCIMetacelloLoadSpec {
  	 #baseline : ''' , package asString
		,
			''',    
      #platforms : [ #pharo, #gemstone ],
#directory: ''repository'',
#onWarningLog : true,
#onConflict: #useLoaded
    }
  ]
}'.
	dirPath := directoryPath , package asString.
	file := (dirPath , '/.smalltalk.ston') asFileReference.
	"file exists ifTrue:[file delete]."
	file ensureDelete.
	
	
	file
		writeStreamEncoded: 'utf-8'
		do: [ :s | s nextPutAll: fileContents withUnixLineEndings  ].
	ciContents := '# set up smalltalk ci and try to build the baseline
on:
  push:
    paths-ignore:
      - ''**.md''
      - ''docs/**''
      - ''.appveyor.yml''
      - ''.travis.yml''
  pull_request:
    paths-ignore:
      - ''**.md''
      - ''docs/**''
      - ''.appveyor.yml''
      - ''.travis.yml''
jobs:
  build:
    strategy:
      matrix:
        smalltalk: [ GemStone64-3.5.7, GemStone64-3.6.1 , Pharo64-8.0, Pharo64-9.0 ]
        os: [ ubuntu-18.04 ]
    runs-on: ${{ matrix.os }}
    name: ${{ matrix.smalltalk }} on ${{ matrix.os }}
    steps:
      - uses: actions/checkout@v2
      - uses: hpi-swa/setup-smalltalkCI@v1
        with:
          smalltalk-image: ${{ matrix.smalltalk }}
      - run: smalltalkci -s ${{ matrix.smalltalk }}
        shell: bash
        timeout-minutes: 15
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}'.
	ciDir := dirPath , '/.github/workflows/'.
	ciDir asFileReference ensureCreateDirectory.
	file := (ciDir , 'main.yml') asFileReference.
	file ensureDelete.
	file
		writeStreamEncoded: 'utf-8'
		do: [ :s | s nextPutAll: ciContents withUnixLineEndings].
	LibC
		runCommand: 'cd ' , dirPath , '; git add .smalltalk.ston .github/workflows; cd -'