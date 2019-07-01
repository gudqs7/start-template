package cn.gudqs.util;

import cn.gudqs.util.crypto.JwtUtils;
import com.auth0.jwt.interfaces.Claim;

import java.util.HashMap;
import java.util.Map;

/**
 * @author wq
 * @date 2018/9/19
 * @description 用户token验证的工具类
 */
public class JwtUtil {

    private static String secret = "84043UR0JFDAJF30QU39QR3U0FU3283";

    /**
     * 校验token是否正确
     *
     * @param token 密钥
     * @return 是否正确
     */
    public static Map<String, Claim> verify(String token) {
        return JwtUtils.verify(token, secret);
    }

    public static String sign(int expire, int unit) {
        Map<String, String> empty = new HashMap<>(1);
        return sign(empty, expire, unit);
    }

    /**
     * 生成签名
     *
     * @return 加密的token
     */
    public static String sign(Map<String, String> data, int expire, int unit) {
        return JwtUtils.sign(data, expire, unit, secret);
    }
}

