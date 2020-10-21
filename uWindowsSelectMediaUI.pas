unit uWindowsSelectMediaUI;

interface

uses
  FMX.Forms,
  Classes,
//  StdCtrls,
  FMX.Types,
//  FMX.UITypes,
  FMX.Graphics,
  uFileCommon,
  uFuncCommon,
  uUIFunction,
  AllImageFrame,
  uSelectMediaDialog;

type
  TWindowsSelectMediaUI=class(TBaseSelectMediaUI)
  public
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Sender:TObject;Image: TBitmap);
    //�Ӷ�ѡͼƬ����
    procedure DoReturnFrameFromAllImageFrame(AFrame:TFrame);
    procedure DoStartSelect;override;
  end;

implementation

{ TWindowsSelectMediaUI }

procedure TWindowsSelectMediaUI.DoReturnFrameFromAllImageFrame(AFrame: TFrame);
var
  I: Integer;
  J: Integer;
  ScaleFactor: Single;
  AFileName:String;
//  AThumbFileName:String;
  APictureName:String;
//var
//  I: Integer;
//  ScaleFactor: Single;
//var
//  AListViewItem:TSkinListViewItem;
  ABitmap:TBitmap;
//  APictures:TStringList;
  ABitmapCodecSaveParams:TBitmapCodecSaveParams;
  AFilePath:String;
begin
  for I := 0 to GAllImageFrame.FSelectedOriginPhotoList.Count-1 do
  begin
      //��Ƭ����
      //�ߴ��������1024,��ô��Ҫ��������С
//      if GAllImageFrame.FSelectedOriginPhotoList[I].Width > 1024 then
//      begin
//          ABitmap:=TBitmap.Create;
//          ScaleFactor := GAllImageFrame.FSelectedOriginPhotoList[I].Width / 1024;
////          GAllImageFrame.FSelectedOriginPhotoList[I].Resize(Round(GAllImageFrame.FSelectedOriginPhotoList[I].Width / ScaleFactor), Round(GAllImageFrame.FSelectedOriginPhotoList[I].Height / ScaleFactor));
//          //���⻨��
//          CopyBitmap(GAllImageFrame.FSelectedOriginPhotoList[I],ABitmap);
//          ABitmap.Resize(Round(ABitmap.Width / ScaleFactor),
//                        Round(ABitmap.Height / ScaleFactor));
//      end
//      else
//      begin

          //Ĭ�Ϸ�ԭͼ
          ABitmap:=GAllImageFrame.FSelectedOriginPhotoList[I];


          AFilePath:=GetApplicationPath+CreateGUIDString()+'.png';
          ABitmap.SaveToFile(AFilePath);
          FSelectMediaDialog.FSelectedFilePaths.Add(AFilePath);

//      end;


//      ABitmap:=GAllImageFrame.FSelectedOriginPhotoList[I];
//      //���һ��ͼƬ
//      AListViewItem:=Self.lvPictures.Prop.Items.Insert(Self.lvPictures.Prop.Items.Count-1);
//      //Ҫ����Icon.Assignǰ��
//      AListViewItem.Icon.Url:='';
//      AListViewItem.Icon.Assign(ABitmap);
//      //���⻨��
//      CopyBitmap(ABitmap,AListViewItem.Icon);




//      //��Ƭ����
//      APictureName:=GlobalClient.Upload.NewFileId;
//      AFileName:=GlobalClient.CurrentUser.GetUserPath_ChatFiles+PathDelim+APictureName+'.png';
////      AThumbFileName:=GlobalClient.CurrentUser.GetUserPath_ChatFiles+PathDelim+APictureName+'.thumb.png';
//
//      ABitmapCodecSaveParams.Quality:=70;
//      GAllImageFrame.FSelectedOriginPhotoList[I].SaveToFile(AFileName,@ABitmapCodecSaveParams);
//
//
//
//      //������Ϣ���ݽṹ
//      AChatContent:=TChatContent.Create;
//      try
//          AChatContent.AddImageElement(AFileName);
//
//          if Assigned(OnSendMessage) then
//          begin
//            OnSendMessage(Self,AChatContent.ToJSON);
//          end;
//
//      finally
//        FreeAndNil(AChatContent);
//      end;


  end;


  if Assigned(FSelectMediaDialog.OnSelectMediaResult) then
  begin
    FSelectMediaDialog.OnSelectMediaResult(FSelectMediaDialog,
                                          FSelectMediaDialog.FSelectedFilePaths);
  end;


  //�ͷ����������е�����ͼ��ԭͼ��ռ�õ��ڴ�
  GAllImageFrame.ClearAfterReturn;


end;

procedure TWindowsSelectMediaUI.DoStartSelect;
begin
  HideFrame;
  //��ѡ��Ƭ
  ShowFrame(TFrame(GAllImageFrame),TFrameAllImage,Application.MainForm,nil,nil,DoReturnFrameFromAllImageFrame,Application,True,False,ufsefNone);
//  GAllImageFrame.FrameHistroy:=CurrentFrameHistroy;
  GAllImageFrame.OnGetPhotoFromCamera:=TakePhotoFromLibraryAction1DidFinishTaking;
  GAllImageFrame.Load(True,0,9);

end;


procedure TWindowsSelectMediaUI.TakePhotoFromLibraryAction1DidFinishTaking(
  Sender: TObject; Image: TBitmap);
var
  AFilePath:String;
begin

  AFilePath:=GetApplicationPath+CreateGUIDString()+'.png';
  Image.SaveToFile(AFilePath);
  FSelectMediaDialog.FSelectedFilePaths.Add(AFilePath);


  if Assigned(FSelectMediaDialog.OnSelectMediaResult) then
  begin
    FSelectMediaDialog.OnSelectMediaResult(FSelectMediaDialog,
                                          FSelectMediaDialog.FSelectedFilePaths);
  end;

end;

initialization
  GlobalSelectMediaUIClass:=TWindowsSelectMediaUI;

end.
