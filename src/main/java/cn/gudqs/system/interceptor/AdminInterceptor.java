package cn.gudqs.system.interceptor;

import cn.gudqs.exception.CustomException;
import cn.gudqs.exception.ErrorCodes;
import cn.gudqs.system.admin.service.ISysAuthService;
import cn.gudqs.util.CommonUtil;
import cn.gudqs.util.JsonResultUtil;
import cn.gudqs.util.JsonUtils;
import cn.gudqs.util.JwtUtil;
import com.auth0.jwt.interfaces.Claim;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 拦截 后台管理请求
 * @author wq
 */
@Component
public class AdminInterceptor implements HandlerInterceptor {

    @Value("${project.env}")
    private String env;

    private static final List<String> NO_AUTH_URLS = new ArrayList<>();

    static {
        NO_AUTH_URLS.add("/admin/menu/findAll");
        NO_AUTH_URLS.add("/admin/auth/findAll");
    }

    @Resource
    private ISysAuthService sysAuthService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
        boolean flag = true;
        String token = request.getHeader("Authorization");
        String userIdKey = "uid";
        try {
            Map<String, Claim> claimMap = JwtUtil.verify(token);
            String tokenType = "type";
            if (claimMap.containsKey(tokenType)) {
                String type = claimMap.get(tokenType).asString();
                boolean rightType = "1".equals(type) || "2".equals(type);
                if (rightType) {
                    if (claimMap.containsKey(userIdKey)) {
                        String userId = claimMap.get(userIdKey).asString();
                        int uid = Integer.parseInt(userId);
                        CommonUtil.setUserId(userId, request);
                        String url = request.getRequestURI();
                        if (!NO_AUTH_URLS.contains(url)) {
                            boolean hasPermission = sysAuthService.hasPermission(uid, url);
                            if (!hasPermission) {
                                throw new CustomException(ErrorCodes.NO_PERMISSION);
                            }
                        }
                    }
                } else {
                    throw new CustomException(ErrorCodes.TOKEN_NOT_MATCH);
                }
            } else {
                throw new CustomException(ErrorCodes.TOKEN_ERROR);
            }
        } catch (Exception e) {
            ErrorCodes errorCodes = ErrorCodes.TOKEN_ERROR;
            if (e instanceof CustomException) {
                CustomException customException = (CustomException) e;
                if (customException.getStatusCode() == ErrorCodes.TOKEN_NOT_MATCH.getCode()) {
                    errorCodes = ErrorCodes.TOKEN_NOT_MATCH;
                }
                if (customException.getStatusCode() == ErrorCodes.NO_PERMISSION.getCode()) {
                    errorCodes = ErrorCodes.NO_PERMISSION;
                }
            }
            if (!CommonUtil.isDev(env)) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print(JsonUtils.getJsonString(JsonResultUtil.errorResult(errorCodes)));
                flag = false;
            } else {
                CommonUtil.setUserId("1", request);
            }
        }
        return flag;
    }


}
