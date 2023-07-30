# Spring Boot

## Constructor @Autowired @PostConstruct 执行顺序

```text
Constructor >> @Autowired >> @PostConstruct
```

## Spring Boot 自动配置原理

### 自动配置的源码

* spring boot 关于自动配置的源码在 spring-boot-autoconfigure-version.jar内
* 想知道spring boot做了哪些自动配置，以debug模式启动，就可以看到自动配置报告

### 运作原理

```java
@SpringBootApplication
        ↓
@EnableAutoConfiguration
        ↓
@Import({AutoConfigurationImportSelector.class})
        ↓
protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
    List<String> configurations = SpringFactoriesLoader.loadFactoryNames(this.getSpringFactoriesLoaderFactoryClass(), this.getBeanClassLoader());
    Assert.notEmpty(configurations, "No auto configuration classes found in META-INF/spring.factories. If you are using a custom packaging, make sure that file is correct.");
    return configurations;
}
上面这个方法扫描具有META-INF/spring.factories文件的jar包，在spring.factories文件中声明了有哪些自动配置
```

### 核心注解

在上面的spring.factories文件里面AutoConfiguration文件里，一般都有下面的条件注解<br>

* @ConditionalOnBean: 当容器里有指定的Bean的条件下
* @ConditionalOnClass: 当类路径下有指定的类的条件下
* @ConditionalOnExpression: 基于SpEL表达式作为判断条件
* @ConditionalOnJava: 基于JVM版本作为判断条件
* @ConditionalOnJndi: 在JNDI存在的条件下查找指定的位置
* @ConditionalOnMissingBean: 当容器里没有指定Bean的情况下
* @ConditionalOnMissingClass: 当类路径下没有指定的类的条件下
* @ConditionalOnNotWebApplication: 当项目不是Web项目的条件下
* @ConditionalOnProperty: 指定的属性是否有指定的值
* @ConditionalOnResource: 类路径是否有指定的值
* @ConditionalOnSingleCandidate: 当指定的Bean在容器中只有一个，或者虽然有多个但是指定首选的Bean
* @ConditionalOnWebApplication: 当前项目是Web项目的条件下
