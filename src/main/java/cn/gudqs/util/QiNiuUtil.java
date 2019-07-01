package cn.gudqs.util;

import cn.gudqs.helper.SpringContextUtil;
import com.qiniu.common.Zone;
import com.qiniu.storage.Configuration;

import java.io.File;
import java.io.InputStream;

/**
 * @author wq
 * @date 2018/11/22
 * @description 七牛云上传图片(文件)
 */
public class QiNiuUtil {

    private static Configuration cfg = new Configuration(Zone.zone2());

    private static String ak;
    private static String sk;
    private static String bucket;
    private static QiNiuUtils.Config config;

    private static void getResource() {
        if (ak == null || sk == null || bucket == null) {
            ak = SpringContextUtil.getEnvironmentProperty("qn.ak");
            sk = SpringContextUtil.getEnvironmentProperty("qn.sk");
            bucket = SpringContextUtil.getEnvironmentProperty("qn.bucket");
            config = new QiNiuUtils.Config();
            config.setAccessKey(ak);
            config.setSecretKey(sk);
            config.setBucket(bucket);
        }

    }

    public static String upload(InputStream inputStream) throws Exception {
        return upload(inputStream, null);
    }

    public static String upload(InputStream inputStream, String path) throws Exception {
        getResource();
        return QiNiuUtils.uploadByConfig(inputStream, path, config, cfg);
    }

    public static String upload(String dir, String path, String key) throws Exception {
        getResource();
        return QiNiuUtils.uploadFileByConfig(new File(dir, path), key, config);
    }

    public String upload(String dir, String path) throws Exception {
        return upload(dir, path, null);
    }

}
