unit waterfall;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Graphics, Dialogs, WaveIn;

const
  FFT_SIZE    = 512;    // Size of FFT input/output arrays
  FFT_SIZE2   = 256;    // FFT_SIZE / 2

type
  TFFTDoneEvent = procedure of object;
  TFFTInArray = array[0..FFT_SIZE-1] of Integer;
  TFFTOutArray = array[0..FFT_SIZE2-1] of Integer;

type
  TWaterfall = class(TWaveIn)
  private
    FFFTStride: integer;
    FCenterFreq: integer;
    FFFTIn_R: TFFTInArray;
    FFFTOut_R: TFFTOutArray;
    FFFTOut_I: TFFTOutArray;
    // Scaled-up, integer, sin/cos tables
    FISin: array[0..FFT_SIZE-1] of Integer;
    FICos: array[0..FFT_SIZE-1] of Integer;
    // static variables
	  FFFT_idx: integer;
	  FFFT_cnt: integer;
    FWaterfallImage: TImage;
    //
    WaterfallBitmap: TBitmap;
    gbl_bin_ave: TFFTOutArray;
    ave_max: integer;
  protected
    procedure SetCenterFreq(f: integer);
    procedure SampleBufferFull(Data : Pointer; Size:longint);
    procedure AddFFT(sample: integer);
    procedure DoFFT;
    procedure UpdateWaterfall;
  public
    constructor Create;
    destructor Destroy; override;
    function Start: boolean;
    procedure Stop;
    procedure ClearDisplay;
    procedure Initialize;
    procedure SetSampleRateAndCenterFreq(fs, fc: integer);
    property FFTOutR: TFFTOutArray read FFFTOut_R;
    property FFTOutI: TFFTOutArray read FFFTOut_I;
    property WaterfallImage: TImage read FWaterfallImage write FWaterfallImage;
  published
    property SampleRate;
    property CenterFreq: integer read FCenterFreq write SetCenterFreq;
    property Stride: integer read FFFTStride;
    property Error;
  end;

implementation

constructor TWaterfall.Create;
var
  i: Integer;
  w, tpi, xi, xsize: Extended;
begin
  inherited;
  FFFT_idx := 0;
  FFFT_cnt := 0;
  // Zero fill statically allocated buffers
  FillChar(FFFTIn_R,SizeOf(FFFTIn_R),#0);
  FillChar(FFFTOut_R,SizeOf(FFFTOut_R),#0);
  FillChar(FFFTOut_I,SizeOf(FFFTOut_I),#0);
  // Initialize sin/cos tables
  tpi := 2.0 * pi;
  xsize := Extended(FFT_SIZE);
  for i := 0 to FFT_SIZE-1 do
  begin
    xi := Extended(i);
  	w := tpi * xi / xsize;
	  FISin[i] := Round(32.0 * sin(w));
	  FICos[i] := Round(32.0 * cos(w));
  end;
  FCenterFreq := 1000;
  FFFTStride := SampleRate div FCenterFreq div 4;
  WaterfallBitmap := TBitmap.Create;
  OnBufferFull := @SampleBufferFull;
  FWaterfallImage := nil;
end;

destructor TWaterfall.Destroy;
begin
  WaterfallBitmap.Destroy;
  inherited;
end;

procedure TWaterfall.Initialize;
begin
  ave_max := 1000;
  FillChar(gbl_bin_ave,SizeOf(gbl_bin_ave),#0);
  ClearDisplay;
end;

procedure TWaterfall.ClearDisplay;
var
  FullRect: TRect;
begin
  // initialize waterfall display
  if Assigned(WaterfallImage) then
  begin
    FullRect := Rect(0,0,WaterfallImage.Width,WaterfallImage.Height);
    WaterfallBitmap.PixelFormat:= pf24bit;
  	WaterfallBitmap.Width := WaterfallImage.Width;
    WaterfallBitmap.Height := WaterfallImage.Height;
    WaterfallBitmap.Canvas.Brush.Color := RGBToColor(0,$1F,0);
    WaterfallBitmap.Canvas.FillRect(FullRect);
    WaterfallImage.Canvas.CopyRect(FullRect,WaterfallBitmap.Canvas,FullRect);
  end;
end;

function TWaterfall.Start: boolean;
begin
  Initialize;
  Result := inherited;
end;

procedure TWaterfall.Stop;
begin
  inherited;
  ClearDisplay;
end;

const
  BINMAX_AVE_WIN = 5; // Length of bin max averaging window

procedure TWaterfall.UpdateWaterfall;
var
  TempBitmap: TBitmap;
  FullRect, Rect1, Rect2: TRect;
  bmwidth, bmheight, v, p: integer;
  fft_out_r, fft_out_i: TFFTOutArray;
	fft_idx: integer;   // Index to fft output array
	bin_val: integer;   // Value of fft output "bin"
	bin_max: integer;   // Maximum value of fft bins
  pix_ofs: integer;
begin
  if not Assigned(WaterfallImage) then Exit;
  with WaterfallImage do
  begin
		bmwidth := Width;
  	bmheight := Height;
    pix_ofs := (bmwidth div 2) - (FFT_SIZE2 * FCenterFreq * FFFTStride * 2 div SampleRate);
	  TempBitmap := TBitmap.Create;
  	TempBitmap.Width := bmwidth;
	  TempBitmap.Height := bmheight;
    FullRect := Rect(0,0,bmwidth,bmheight);
    Rect1 := Rect(0,0,bmwidth,bmheight-1);
    Rect2 := Rect(0,1,bmwidth,bmheight);
    (* == this code draws a waterfall display == *)
	  with TempBitmap.Canvas do
  	begin
      CopyRect(Rect2,WaterfallBitmap.Canvas,Rect1);
    	// copy previous waterfall bitmap shifted down 1 pixel
      // do the FFT on the input array
      gbl_bin_ave[0] := 0;
      bin_max := 0;
      for fft_idx := 0 to FFT_SIZE2 - 1 do
      begin
      	// Calculate signal power at each frequency (bin)
      	fft_out_r[fft_idx] := FFTOutR[fft_idx] div 8;
	      fft_out_i[fft_idx] := FFTOutI[fft_idx] div 8;
	      bin_val := fft_out_r[fft_idx]*fft_out_r[fft_idx] + fft_out_i[fft_idx]*fft_out_i[fft_idx];
        // Calculate average bin values
	      gbl_bin_ave[fft_idx] := ( (gbl_bin_ave[fft_idx] * (BINMAX_AVE_WIN-1) + bin_val) div BINMAX_AVE_WIN );
        // Record max bin value
      	if bin_max < bin_val then
	        bin_max := bin_val;
        // Scale pixel values to 255 depending on ave max value
      	v := (255 * bin_val) div ave_max;
	      if v > 255 then v := 255;
        p := fft_idx + pix_ofs;
        if (p >= 0) and (p < bmwidth) then
          TempBitmap.Canvas.Pixels[p,0] := RGBToColor(0,v,0);
      end;
      // Calculate sliding window average of max bin value
      ave_max := (ave_max*(BINMAX_AVE_WIN-1) + bin_max) div BINMAX_AVE_WIN;
      if ave_max = 0 then ave_max := 1;
      // copy waterfall back to waterfall bitmap
      WaterfallBitmap.Canvas.CopyRect(FullRect,TempBitmap.Canvas,FullRect);
      // draw BFO position
  	  Pen.Color := clRed;
		  MoveTo(bmwidth div 2,0);
  		LineTo(bmwidth div 2,bmheight-1);
    end;
  	// now draw waterfall display
    WaterfallImage.Canvas.CopyRect(FullRect,TempBitmap.Canvas,FullRect);
	  TempBitmap.Free;
  end;
end;

procedure TWaterfall.SetCenterFreq(f: integer);
begin
  FFFTStride := FSampleRate div f div 4;
  FCenterFreq := FSampleRate div FFFTStride div 4;
  if f <> FCenterFreq then
    MessageDlg(Format('Center frequency set to %d Hz. A %d Hz center frequency cannot be used at this sample rate',[FCenterFreq,f]),mtInformation,[mbOK],0);
end;

procedure TWaterfall.SetSampleRateAndCenterFreq(fs, fc: integer);
begin
  FSampleRate := fs;
  SetCenterFreq(fc);
end;

procedure TWaterfall.SampleBufferFull(Data : Pointer; Size:longint);
var
  i: integer;
begin
  for i := 0 to Size - 1 do
  begin
    AddFFT(Ord(PChar(Data)[i])-128);
    if (FFFT_idx >= FFT_SIZE) then
    begin
      DoFFT;
      if Assigned(WaterfallImage) then
        UpdateWaterfall;
    end;
  end;
end;

procedure TWaterfall.DoFFT;
// simple, integer FFT function
var
  i, j, w: integer;
  sum_i, sum_q: integer; // in-phase and quadrature summation
begin
  // Calculate output bins
  for i := 0 to FFT_SIZE2 - 1 do
  begin
    w := 0;
    sum_q := 0;
	  sum_i := 0;
  	// Sum input values
  	for j := 0 to FFT_SIZE - 1 do
    begin
  	  w := w + i;
  	  if w >= FFT_SIZE then
    		w := w - FFT_SIZE;
  	  sum_i := sum_i + FFFTIn_R[j] * FISin[w];
  	  sum_q := sum_q + FFFTIn_R[j] * FICos[w];
    end;
    // Normalized summations to bins */
    FFFTOut_R[i] := sum_i div FFT_SIZE;
  	FFFTOut_I[i] := sum_q div FFT_SIZE;
  end;
end;

procedure TWaterfall.AddFFT(sample: integer);
begin
  if FFFT_idx >= FFT_SIZE then
    FFFT_idx := 0;
  if FFFT_cnt = 0 then
	  FFFTIn_R[FFFT_idx] := sample
  else
	  FFFTIn_R[FFFT_idx] := FFFTIn_R[FFFT_idx] + sample;
  Inc(FFFT_cnt);
  if FFFT_cnt >= FFFTStride then
  begin
	  Inc(FFFT_idx);
	  FFFT_cnt := 0;
  end;
end;

end.

