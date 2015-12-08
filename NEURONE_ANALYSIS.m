DATADIR = '/ukko/scratch/jari/2015-12-04T142754/';
SESSIONS = [1, 2, 3];
OUTDIR = '/tmp/neurone_analysis/';
EVENTS = '/home/jari/work/shimmer/testrun2/video_offsets.csv';

if isdir(OUTDIR), rmdir(OUTDIR, 's'); end;

mkdir(OUTDIR)

read_neurone(DATADIR, OUTDIR, SESSIONS, EVENTS);
