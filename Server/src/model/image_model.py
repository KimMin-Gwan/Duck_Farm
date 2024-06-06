

class Image_Model:
    def __init__(self, databasss) -> None:
        self.__databass = databasss
        self.__image = None

    """
    1. 이미지 아이디 만들기
    1.1 db한테 bias앞으로 된 사진 갯수 받아오니
    1.2 사진 이름을 bias + - + 사진 갯수 + n  으로 반복문 
    1.3 db한테 bias 앞으로 된 사진 갯수 n만큼 추가

    2. 메타정보 만들기
    2.1 Image 데이터 생성
    2.2 ㅇ위에서 생성한 iid 매칭
    2.3 db에 저장

    3. iid 리턴
    """

    def make_image_data(self, request):
        iids = []
        db_image_num = self.__databass.get_bias_image_num_with_bid(request['bid'])
        upload_image_num = len(request['image_filenames'])

        for n in range (upload_image_num):
            iid = request['bid'] + "-" + str(db_image_num + n)
            iids.append(iid)

        self.__databass.add_bias_image_num(upload_image_num)


        self.__image = Image(request)
        self.__image.set_iid(iids)
        self.__databass.save_new_image_data(self.__image)

        return iids


    def get_bias_image_data(self,bid):
        result = .find_image_with_bid(bid)
        return result
        




class Image:
    def __init__(self) -> None:
        self.__iid = ''
        self.__iname=''
        self.__bid=''
        self.__iamge_type=''
        self.__uid=''
        self.__image_info=''
        self.__location=''
        self.__uploadedDate=''
        self.__scheduleDate=''
        self.__scheduleName=''
        pass

    def set_iid(self, iids):
        self.__iid = iids
        return 



    