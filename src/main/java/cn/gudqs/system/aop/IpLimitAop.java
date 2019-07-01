package cn.gudqs.system.aop;

import cn.gudqs.consts.RedisKeyConst;
import cn.gudqs.exception.ErrorCodes;
import cn.gudqs.system.annotation.IpLimit;
import cn.gudqs.util.CommonUtil;
import cn.gudqs.util.MathUtil;
import cn.gudqs.util.StringUtil;
import cn.gudqs.util.redis.RedisUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.jboss.logging.Logger;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * @author wq
 * @date 2019-01-16
 * @description 请求速度限制拦截
 */
@Order(2)
@Aspect
@Component
public class IpLimitAop {

    private Logger logger = Logger.getLogger(IpLimitAop.class);

    @Around(value = "@annotation(ipLimit)", argNames = "jp, ipLimit")
    public Object around(ProceedingJoinPoint jp, IpLimit ipLimit) throws Throwable {
        String methodKey = jp.getSignature().getDeclaringType().getName() + "." + jp.getSignature().getName();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        if (request != null) {
            String ip = CommonUtil.getRealIp(request);
            logger.debug("ipLimit: " + ip + ":" + methodKey);
            String stopTimeKey = RedisKeyConst.REQUEST_IP_LIMIT_STOP_TIME_PREFIX + ip + "-" + methodKey;
            String needStop = RedisUtils.get(stopTimeKey);
            if (needStop != null && StringUtil.bool(needStop)) {
                returnError(response, ip, methodKey);
                return null;
            }
            String key = RedisKeyConst.REQUEST_IP_LIMIT_PREFIX + ip + "-" + methodKey;
            String result = RedisUtils.get(key);

            int now = 0;
            if (result != null && MathUtil.isInt(result)) {
                now = Integer.parseInt(result);
            }
            if (now > ipLimit.value()) {
                returnError(response, ip, methodKey);
                RedisUtils.set(stopTimeKey, "1");
                RedisUtils.expire(stopTimeKey, ipLimit.stop(), TimeUnit.SECONDS);
                return null;
            }
            RedisUtils.set(key, (now + 1) + "");
            RedisUtils.expire(key, ipLimit.second(), TimeUnit.SECONDS);
            return jp.proceed();
        }
        return null;
    }

    private void returnError(HttpServletResponse response, String ip, String methodKey) throws IOException {
        logger.error("ipLimit--> requestTooFast: " + ip + ":" + methodKey);
        if (response != null) {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print("" + "{\"result\":\"" + ErrorCodes.REQUEST_TOO_FAST.getMsg() + "\",\"errDesc\":\"" + ErrorCodes.REQUEST_TOO_FAST.getMsg() + "\"," + "\"code\":\"" + ErrorCodes.REQUEST_TOO_FAST.getCode() + "\", \"success\": false}");
        }
    }


}

