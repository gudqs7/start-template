package cn.gudqs.system.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author wq
 * @date 2019-02-05
 * @description jd-plus
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IpLimit {
    /**
     * 指定时间内运行多少次
     */
    int value() default 5;

    /**
     * 指定时间(秒)
     */
    int second() default 2;

    /**
     * 触发时 封禁多少秒
     */
    int stop() default 90;

}
