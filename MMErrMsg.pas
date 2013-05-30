unit
    MMErrMsg;

interface

const
  mm_open_error = 'Error opening sound device. ';
  mm_prep_error = 'Error preparing headers. ';
  mm_start_error = 'Error starting sound device. ';
  mm_read_error = 'Error reading sound device. ';
  mm_stop_error = 'Error stopping sound device. ';
  mm_close_error = 'Error closing sound device. ';

function translate_mm_error (error_number: word): pChar;

implementation

uses
    MMSystem, SysUtils;

function translate_mm_error (error_number: word): pChar;
begin
  case error_number of
           mmsyserr_Error: translate_mm_error := 'Unspecified error';
     mmsyserr_BadDeviceID: translate_mm_error := 'Device ID out of range';
      mmsyserr_NotEnabled: translate_mm_error := 'Driver failed enable';
       mmsyserr_Allocated: translate_mm_error := 'Device already allocated';
     mmsyserr_InvalHandle: translate_mm_error := 'Device handle is invalid';
        mmsyserr_NoDriver: translate_mm_error := 'No device driver present';
           mmsyserr_NoMem: translate_mm_error := 'Memory allocation error';
    mmsyserr_NotSupported: translate_mm_error := 'Function not supported';
       mmsyserr_BadErrNum: translate_mm_error := 'Error value out of range';
       mmsyserr_InvalFlag: translate_mm_error := 'Invalid flag passed';
      mmsyserr_InvalParam: translate_mm_error := 'Invalid parameter passed';
         waverr_BadFormat: translate_mm_error := 'Unsupported wave format';
      waverr_StillPlaying: translate_mm_error := 'Something is still playing';
        waverr_Unprepared: translate_mm_error := 'Header not prepared';
              waverr_Sync: translate_mm_error := 'Device is synchronous';
       midierr_Unprepared: translate_mm_error := 'Header not prepared';
     midierr_StillPlaying: translate_mm_error := 'Something is still playing';
            midierr_NoMap: translate_mm_error := 'No current map';
         midierr_NotReady: translate_mm_error := 'Hardware is still busy';
         midierr_NoDevice: translate_mm_error := 'Port no longer connected';
     midierr_InvalidSetup: translate_mm_error := 'Invalid setup';
           timerr_NoCanDo: translate_mm_error := 'Request not completed';
            timerr_Struct: translate_mm_error := 'Time struct size';
             joyerr_Parms: translate_mm_error := 'Bad parameters';
           joyerr_NoCanDo: translate_mm_error := 'Request not completed';
         joyerr_Unplugged: translate_mm_error := 'Joystick is unplugged';
     mmioerr_FileNotFound: translate_mm_error := 'File not found';
      mmioerr_OutOfMemory: translate_mm_error := 'Out of memory';
       mmioerr_CannotOpen: translate_mm_error := 'Cannot open';
      mmioerr_CannotClose: translate_mm_error := 'Cannot close';
       mmioerr_CannotRead: translate_mm_error := 'Cannot read';
      mmioerr_CannotWrite: translate_mm_error := 'Cannot write';
       mmioerr_CannotSeek: translate_mm_error := 'Cannot seek';
     mmioerr_CannotExpand: translate_mm_error := 'Cannot expand file';
    mmioerr_ChunkNotFound: translate_mm_error := 'Chunk not found';
       mmioerr_Unbuffered: translate_mm_error := 'File is unbuffered';
  else
      translate_mm_error := PChar(Format('Unknown error code: %d',[error_number]));
  end;
end;

begin
end.
