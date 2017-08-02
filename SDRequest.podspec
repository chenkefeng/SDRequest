
Pod::Spec.new do |s|
    s.name             = 'SDRequest'
    s.version          = '1.0'
    s.summary          = '基于Moya封装的网络请求库'

    s.homepage         = 'https://github.com/chenkefeng/SDRequest'

    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'chenkefeng_java@163.com' => 'chenkefeng@kuaicto.com' }
    s.source           = { :git => 'https://github.com/chenkefeng/SDRequest.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'

    s.source_files = 'SDRequest/Classes/**/*'

    s.dependency 'Moya/RxSwift'
    s.dependency 'HandyJSON'
end
