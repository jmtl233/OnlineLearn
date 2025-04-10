module.exports = {
    lintOnSave: false, // 关闭eslint校验
    devServer: {
        port: 9252,
        overlay: { // 关闭eslint校验
            warning: false,
            errors: false

        },
        proxy: {  //配置跨域
            '/api': {
                target: 'http://localhost:9251',
                changeOrigin: true,
                pathRewrite: { '^/api': '' },
                proxyTimeout: 60000,
                onError: (err, req, res) => {
                    console.error('代理错误:', err);
                }
            },
        },
    }
};


