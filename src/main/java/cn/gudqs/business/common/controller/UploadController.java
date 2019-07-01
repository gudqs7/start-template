package cn.gudqs.business.common.controller;

import cn.gudqs.base.BaseController;
import cn.gudqs.base.ResultBean;
import cn.gudqs.util.QiNiuUtil;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


/**
 * @author generator-wq
 * @date 2019/03/19 10:07:30
 */
@RestController
@RequestMapping("/admin/upload/")
@Api(description = "通用上传")
public class UploadController extends BaseController {

    @PostMapping("/upload")
    public ResultBean upload(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        String path = QiNiuUtil.upload(multipartFile.getInputStream());
        return success(path);
    }

}