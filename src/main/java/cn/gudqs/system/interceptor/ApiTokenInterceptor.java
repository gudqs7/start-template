package cn.gudqs.system.interceptor;

import cn.gudqs.exception.CustomException;
import cn.gudqs.exception.ErrorCodes;
import cn.gudqs.util.CommonUtil;
import cn.gudqs.util.JsonResultUtil;
import cn.gudqs.util.JsonUtils;
import cn.gudqs.util.JwtUtil;
import com.auth0.jwt.interfaces.Claim;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 拦截 api 请求
 *
 * @author wq
 */
@Component
public class ApiTokenInterceptor implements HandlerInterceptor {

    @Value("${project.env}")
    private String env;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        boolean flag = true;
        String token = request.getHeader("Authorization");
        String userIdField = "uid";
        try {
            Map<String, Claim> claimMap = JwtUtil.verify(token);
            String tokenType = "type";
            if (claimMap != null && claimMap.containsKey(tokenType)) {
                String type = claimMap.get(tokenType).asString();
                boolean rightType = !"0".equals(type) && !"2".equals(type);
                if (rightType) {
                    throw new CustomException(ErrorCodes.TOKEN_NOT_MATCH);
                }
                if (claimMap.containsKey(userIdField)) {
                    String userId = claimMap.get(userIdField).asString();
                    CommonUtil.setUserId(userId, request);
                }
            }
        } catch (Exception e) {
            ErrorCodes errorCodes = ErrorCodes.TOKEN_ERROR;
            if (e instanceof CustomException) {
                if (((CustomException) e).getStatusCode() == ErrorCodes.TOKEN_NOT_MATCH.getCode()) {
                    errorCodes = ErrorCodes.TOKEN_NOT_MATCH;
                }
            }
            if (!CommonUtil.isDev(env)) {
                flag = false;
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print(JsonUtils.getJsonString(JsonResultUtil.errorResult(errorCodes)));
            } else {
                request.setAttribute(userIdField, 1);
            }
        }
        return flag;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
