package kr.or.ddit.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.domain.Attach;
import kr.or.ddit.service.AttachService;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Controller
public class FileUploadUtil {
	private String uploadFolder;


	@Autowired
	AttachService attchService;

	//파일 업로드 실행 + DB처리
	public int fileUploadAction(MultipartFile[] multipartFiles, HttpServletRequest req) {
		log.info("파일 업로드를 수행합니다.");

		uploadFolder = req.getRealPath("\\") + "\\resources\\upload" + "\\" +getFolder();
		
		List<Attach> attachList = new ArrayList<Attach>();

		//1) 파일 업로드 수행(연/월/일, UUID)
		//1-1) 연/월/일
		File uploadPath = new File(uploadFolder, getFolder());
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}

		//<input type="file" name="" multiple
		//ATTACH 테이블의 seq 컬럼에 들어갈 값
		int fileSn = 1;
		for(MultipartFile multipartFile : multipartFiles) {
			log.info("---------------");
			log.info("파일명 : " + multipartFile.getOriginalFilename());
			log.info("파일 크기 : " + multipartFile.getSize());

			//IE처리 => 경로를 제외한 파일명만 추출
			//c:\\upload\\image01.jpg => image01.jpg
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);

			UUID uuid = UUID.randomUUID();
			//image01.jpg => aoisonsppois_image01.jpg(uploadFileName)
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			//C:.....\\upload\\
			//2022\\10\\31\\aoisonsppois_image01.jpg
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				//파일 복사
				multipartFile.transferTo(saveFile);

				Attach attach = new Attach();
				attach.setFileSn(fileSn++);
				attach.setFileStreCours(uploadFolder.replace("\\", "/")+"/" + getFolder().replace("\\", "/") + "/" + uploadFileName);
				//getFolder() : 연/월/일
				//uploadFileName : UUID + 파일명
				//윈도 경로 => \\2022\\10\\31\\aoisonsppois_image01.jpg
				//웹 경로 => /2022/10/31/aoisonsppois_image01.jpg
				attach.setStreFileNm("/" + getFolder().replace("\\", "/") + "/" + uploadFileName);
				attach.setOrignlFileNm(multipartFile.getOriginalFilename());
				log.info("attachName : " + getFolder().replace("\\", "/") + "/" + uploadFileName);
				attach.setFileSize(Long.valueOf(multipartFile.getSize()).intValue());
				//MIME 타입
				attach.setFileExtsn(Files.probeContentType(saveFile.toPath()));

				attachList.add(attach);

				//썸네일 처리
				if(checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(
							new File(uploadPath,"s_"+uploadFileName)
							);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}


		}//end for
		int result1 = 0;
		//2) ATTACH 테이블에 다중 insert
		//SEQ(자동증가), TID, ATTACH_NAME, ATTACH_SIZE, ATTACH_TYPE, REGIST_DATE(sysdate)
//		for(Attach attach : attachList) {
//			log.info("attachVO : " + attach.toString());
			log.info("attachVOList================================================= : " + attachList.toString());

			int result = this.attchService.insertAttch(attachList);
			if(result >0) {
				result1 = 1;
			}
//		}

		//Attach 테이블에 insert 실행

		log.info("파일 업로드를 완료했습니다.");
		return result1;
	}

	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-10-28 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//날짜 객체 생성(java.util패키지)
		Date date = new Date();
		//2022-10-28
		String str = sdf.format(date);
		//File.separator는 폴더 형식으로 만듦
		return str.replace("-", File.separator);
	}

	//이미지인지 체킹(썸네일 용)
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	//이미지의 경우 특별한 경우가 아니면 섬네일을 제작해줘야 함
	public boolean checkImageType(File file) {
		/*
		 .jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		 */
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType :" + contentType);//image/jpeg, image/png, image/gif
			//MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
}
